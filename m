Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVKTX6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVKTX6e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVKTX6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:58:34 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:37412 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S932136AbVKTX6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:58:33 -0500
Date: Sun, 20 Nov 2005 18:58:32 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.15-rc2
In-reply-to: <1132526214.15938.5.camel@localhost>
To: linux-kernel@vger.kernel.org
Message-id: <200511201858.32171.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511200018.11791.gene.heskett@verizon.net>
 <1132526214.15938.5.camel@localhost>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 November 2005 17:36, Kasper Sandberg wrote:
>On Sun, 2005-11-20 at 00:18 -0500, Gene Heskett wrote:
>> On Saturday 19 November 2005 22:40, Linus Torvalds wrote:
>> >There it is (or will soon be - the tar-ball and patches are still
>> >uploading, and mirroring can obviously take some time after that).
>>
>> First breakage report, tvtime, blue screen no audio.  Trying slightly
>> different .config for next build.  My tuner (OR51132) seems to be
>> permanently selected in an xconfig screen.  Dunno if thats good or
>> bad ATM.
>
>if it needs to be loaded with a parameter you will need to build it as
> a module.. my saa7134 chip needs card=9.

Its never needed an argument before.

>i am experiencing same problems with saa7134, no video, however i do
> get audio.

I wasn't, total digital gibberish on screen.

A full powerdown reboot to 2.6.14.2 fixed it.

>this is a way to (incorrectly according to v4l devs) "fix" it:
>drivers/media/video/video-buf.c
>change line 1233 to this:
>        vma->vm_flags |= VM_DONTEXPAND;

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

