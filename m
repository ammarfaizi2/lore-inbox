Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUHVGBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUHVGBY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 02:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUHVGBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 02:01:24 -0400
Received: from wasp.net.au ([203.190.192.17]:7080 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S266233AbUHVGAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 02:00:46 -0400
Message-ID: <412836B0.4010309@wasp.net.au>
Date: Sun, 22 Aug 2004 10:01:20 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josan Kadett <corporate@superonline.com>
CC: "'Chris Siebenmann'" <cks@utcc.utoronto.ca>, linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level
References: <S264980AbUHVBIi/20040822010839Z+1297@vger.kernel.org>
In-Reply-To: <S264980AbUHVBIi/20040822010839Z+1297@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josan Kadett wrote:
> Well, the device fails only in one type of operation, that is when it has to
> receive packets from an internal port, it sends packets via its external IP
> address. 
> 
> I have managed to disable IP header checksumming by hacking the kernel (in
> file ip_input.c). Now I have to do the same for tcp_input.c and udp.c .
> Packet mangling will not be required because when I turn the rp_filter off,
> the kernel does not care whether it is coming from the intended source or
> not.
> 

Just a completely random thought. What about re-calculating the checksum and correcting it when the 
packet hits the IP layer prior to it being passed out to the relevant protocol handlers?

Regards,
Brad
