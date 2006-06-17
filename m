Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWFQJPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWFQJPY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 05:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWFQJPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 05:15:24 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:9903 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750733AbWFQJPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 05:15:24 -0400
Date: Sat, 17 Jun 2006 11:15:16 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Phillip Lougher <phil.lougher@gmail.com>, linux-kernel@vger.kernel.org,
       phillip@lougher.demon.co.uk
Subject: Re: squashfs size in statfs
In-Reply-To: <449332CC.6070809@zytor.com>
Message-ID: <Pine.LNX.4.61.0606171112210.15799@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0606051243100.579@yvahk01.tjqt.qr> 
 <e62cs9$csl$1@terminus.zytor.com>  <Pine.LNX.4.61.0606151151020.9572@yvahk01.tjqt.qr>
 <cce9e37e0606161511p5fc33a8dtb63432060f9e3784@mail.gmail.com>
 <449332CC.6070809@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Yes, because CRAM does it that way, and maybe zisofs does it too:
>> 
>> Zisofs doesn't (H. Peter Anvin should know as he wrote it :-) ).
>> 
>> Statfs should return the size of the filesystem, not the amount of
>> data the filesystem  represents.  In this respect the behaviour of
>> Squashfs and Zisofs is correct.
>> 
>> This is analogous to performing stat on a gzipped file.  The stat
>> returns the size of the compressed file, not the uncompressed size.
>
> A better analogy is it is like statting a sparse file on, say, an ext3
> filesystem.  stat (ls -s) and statfs report the amount of storage consumed.
>
Too bad. Would have been a good indicator of how much space you need to 
copy an entire disc to disk, rather than running and waiting for du -s to 
complete.

So cramfs would need fixing.


Jan Engelhardt
-- 
