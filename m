Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265205AbUGDQz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265205AbUGDQz0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 12:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUGDQz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 12:55:26 -0400
Received: from turkey.mail.pas.earthlink.net ([207.217.120.126]:35203 "EHLO
	turkey.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S265205AbUGDQzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 12:55:24 -0400
From: Eric <eric@cisu.net>
Reply-To: eric@cisu.net
To: Lasse Bang Mikkelsen <lbm-list@fatalerror.dk>
Subject: Re: Strange DMA timeouts
Date: Sun, 4 Jul 2004 11:55:26 -0500
User-Agent: KMail/1.6.2
References: <1088958931.3205.8.camel@slaptop>
In-Reply-To: <1088958931.3205.8.camel@slaptop>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407041155.26042.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 July 2004 11:35 am, you wrote:
> Hi
>
> I keep getting these DMA timeouts under heavy harddrive load, ex. when
> unpacking big tarballs, transfering from USB harddrive etc.

More info needed. Please provide kernel version, dmesg, lspci,lsmod to start. 
You most certainly wont get any help without this info. Provide harddrive 
manufacturer USB 2.0? USB 1.1? 

> hda: dma_timer_expiry: dma status == 0x21
> hda: DMA timeout error
> hda: dma timeout error: status=0xd0 { Busy }
>
> hda: DMA disabled
> ide0: reset: success
>
> Is this a sign of harddisk failure or could this be a kernel problem?

If it would help the maintainers I also had this problem, or a related 
problem, with 2.6.5-gentoo-r1. Whenever I was ripping CD's to MP3 via KDE's 
copy paste from the audiocd ioslave, I could get a few CD's in before this 
would happen. However, if I did two CD's at a time it would almost always 
happen before either CD was done.

Furthermore I think there may be a memory leak on that codepath, because 
whenever it would reset the bus, my free memory would drop to about 69M (of 
1GB, usually 700-800 free) and my system would swap alot. A little bit after 
the DMA Disabled and ATAPI reset my machine would hang hard. However, if I 
didnt rip CD's that day and it didnt go into swapping, my machine runs 
perfectly fine.

Since I have switched to 2.6.7-gentoo-r8 and have no more CD's to rip 
unfortunatly so I don't know if an upgrade has solved my problem.

	 If this sounds like a kernel bug  or related to the original poster I can 
try to reproduce it and give more info. Sorry if its unrelated or has been 
fixed, then just ignore my message.

> Thanks.
