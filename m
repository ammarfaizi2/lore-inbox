Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUGYNnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUGYNnM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 09:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUGYNnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 09:43:12 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:45514 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S263971AbUGYNnG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 09:43:06 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crash(s)?
Date: Sun, 25 Jul 2004 09:43:05 -0400
User-Agent: KMail/1.6
References: <200407242156.40726.gene.heskett@verizon.net> <200407250012.52743.gene.heskett@verizon.net> <200407250909.00227.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200407250909.00227.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407250943.05592.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.55.2] at Sun, 25 Jul 2004 08:43:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 July 2004 02:09, Denis Vlasenko wrote:
>On Sunday 25 July 2004 07:12, Gene Heskett wrote:
>> >Not much... at least you can look up that EIP in System.map.
>> >Also, do you really need all that sound stuff?
>>
>> It seems to all come in with the main driver for the ALC650.  And
>> it works pretty good once i got it figured out.  Everything but
>> the bt878 audio, which is so far down the s/s+n isn't more than 30
>> db.
>
>I meant "do not use it and see whether that helps".
>
>> c0164376 isn't a label, but its in between these two in the
>> System.map c0164340 t prune_dcache
>> c0164500 T shrink_dcache_sb
>>
>> But thats all I can deduce from here.
>
>Of course, it points _inside_ prune_dcache(), not at the very
>first instruction of it.
>
>Do:
>
>objdump -d <file containing prune_dcache>.o >file.objdump

Humm, maybe I missunderstand you:
[root@coyote linux-2.6.8-rc2-nf2]# objdump -d 
</boot/vmlinuz-2.6.8-rc2-nf2>.o >file.objdump
objdump: a.out: No such file or directory

So I grepped to locate dcache.o (its in the fs subdir) but its still 
an error:
----------------
[root@coyote fs]# objdump -d <dcache.o >file.objdump
objdump: a.out: No such file or directory
------------------
and it (dcache.o) does exist.  What am I doing wrong?

>and
>make path/to/<file containing prune_dcache>.s
>
>and using resulting .objdump and .s files, find exact
>instruction and C code line where it died.
>--
>vda

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
