Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUHVGQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUHVGQu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 02:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUHVGQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 02:16:50 -0400
Received: from wasp.net.au ([203.190.192.17]:31656 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S266250AbUHVGQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 02:16:49 -0400
Message-ID: <41283A74.101@wasp.net.au>
Date: Sun, 22 Aug 2004 10:17:24 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josan Kadett <corporate@superonline.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josan Kadett wrote:
> That is certainly what I require but I need some guidelines; I investigated
> into the issue and fount out that;
> 
> - By only changing the source address coded in the IP header
> - And by just applying checksum to IP header [Not TCP or UDP]
> 
> The problem would be gone since when the source IP in the IP address field
> is validated, the checksum in the underlying protocol is automatically
> validated (because the sender system had already computed this CRC using the
> IP address which we want to write onto the packet)
> 
> I do not have much time to build a code just for this purpose and thus I am
> looking for a simple app. or some other way...

So if we took any packet that came in from 192.168.1.1 and substituted 192.178.77.1 for the Source 
address and then re-calculated the IP checksum you would be up and running?

Regards,
Brad
