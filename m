Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266494AbUHVHD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266494AbUHVHD7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 03:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUHVHD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 03:03:59 -0400
Received: from wasp.net.au ([203.190.192.17]:34473 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S266324AbUHVHDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 03:03:55 -0400
Message-ID: <4128457C.7090001@wasp.net.au>
Date: Sun, 22 Aug 2004 11:04:28 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josan Kadett <corporate@superonline.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level
References: <S266258AbUHVGYp/20040822062445Z+1742@vger.kernel.org>
In-Reply-To: <S266258AbUHVGYp/20040822062445Z+1742@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josan Kadett wrote:
> **Indeed there is no longer such a need to recalculate the IP checksum
> because I have found a way to disable it by patching the kernel. So, only
> requirement is this;
> 
> Change the source address of the packet before it reaches to the socket
> buffer aka skbuff.h. Because if it reaches that code with the wrong IP
> header, the csum will just drop it away.

The main reason I suggested correcting the checksum is if it was done that way, the kernel would 
behave normally for all other IP traffic and simply do a dodgy on only traffic from 192.168.1.1

If nobody else jumps in, let me think about it for a day or so and I'll see what I can do. It's been 
a couple of years since I last looked at the network code though.

What kernel are you running?

Regards,
Brad
