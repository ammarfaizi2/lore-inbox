Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUHDM5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUHDM5Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 08:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265154AbUHDM5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 08:57:23 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:41168 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S264857AbUHDM5U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 08:57:20 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.8-rc3
Date: Wed, 4 Aug 2004 08:57:19 -0400
User-Agent: KMail/1.6.82
References: <Pine.LNX.4.58.0408031505470.24588@ppc970.osdl.org> <200408041407.39871.lkml@kcore.org>
In-Reply-To: <200408041407.39871.lkml@kcore.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408040857.19426.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [141.153.91.21] at Wed, 4 Aug 2004 07:57:20 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 August 2004 08:07, Jan De Luyck wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>On Wednesday 04 August 2004 00:09, Linus Torvalds wrote:
>> Tons of small fixes all around the tree.
>>
>> There's an optimized assembly AES implementation for x86 (from
>> Brian Gladman), and a number of driver updates, all of which are
>> reasonably minor.
>>
>> It would be good if people only sent serious stuff for a while,
>> and we can do a real 2.6.8, ok?
>>
>> 		Linus
>
>Works like a charm, only one comment:
>
>Mounting my vfat partitions gave me this error:
>
>FAT: codepage or iocharset option didn't specified
>     File name can not access proper (mounted as read-only)
>
>which was easily fixed by supplying a iocharset= mount option. But
> according to the man page of mount:
>
>       iocharset=value
>              Character set to use for converting between 8 bit
> characters and 16 bit Unicode characters. The default is iso8859-1.
>  Long file- names are stored on disk in Unicode format.
>
>the default is iso8859-1. Has this default gone haywire somewhere?
>
>Thanks anyway for another great kernel :)
>
>Jan

I too seem to have a font problem in the early boot, I have nothing 
but some flashing as the cursor moves back and forth from kernel 
unpack to the line where it reports setting the default font, at 
which time the screen comes alive and is then readable as the boot 
continues.  This font setup occurs about 4 or 5 lines before the init 
signs on.  This condition has existed since someplace around 2.6.6 
here.  I have the 3 normally used for western english fonts compiled 
in too.  437, iso8859-1, and utf-8.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
