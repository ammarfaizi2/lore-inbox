Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbTLVPFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 10:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbTLVPFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 10:05:41 -0500
Received: from 12-211-66-152.client.attbi.com ([12.211.66.152]:12674 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S264405AbTLVPFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 10:05:40 -0500
Message-ID: <3FE70842.1020502@comcast.net>
Date: Mon, 22 Dec 2003 07:05:38 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nicklas Bondesson <nikomail@hotmail.com>
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
 (PDC20271)
References: <BAY8-DAV19JuYW8iOqz00010341@hotmail.com>
In-Reply-To: <BAY8-DAV19JuYW8iOqz00010341@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicklas Bondesson wrote:
> Do I have to include anything else than this??
> 
> <*> ATA/IDE/MFM/RLL support
>   IDE, ATA and ATAPI Block devices -->
> 	<*> PROMISE PDC202{68|69|70|71|75|76|77} support (NEW)
> 	[*] Special FastTrack Feature
> 
> 	<*> Support for IDE Raid Controllers (EXPERIMENTAL)
> 	<*> Support Promise software RAID (Fasttrak(tm)) (EXPERIMENTAL)
>  
> /Nicke
> 

I believe that should do it. dmesg doesn't have any info about the ataraid
driver being loaded? If it's scrolling out of the kernel buffer, you can try
bumping up the size through the kernel config. The option is under the "Kernel
Hacking" section and is CONFIG_LOG_BUF_SHIFT. Change it to 17 or 18 to be sure.
A reboot with this new kernel should give you a full dmesg afterward, hopefully
showing what's wrong with the ataraid stuff.

-Walt

PS. I don't remember when this took place, but there were some changes to the
promise drivers in 2.4 around 2.4.21 I think. There should be drivers for both
the older Promise and the newer. I remember always choosing both, complete with
pdcraid just to be sure.


