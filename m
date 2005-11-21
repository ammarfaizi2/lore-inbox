Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVKUXwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVKUXwj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVKUXwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:52:39 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:49445 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751133AbVKUXwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:52:38 -0500
Date: Mon, 21 Nov 2005 18:52:36 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.15-rc2
In-reply-to: <1132607845.15938.30.camel@localhost>
To: linux-kernel@vger.kernel.org
Message-id: <200511211852.36458.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511201858.32171.gene.heskett@verizon.net>
 <1132607845.15938.30.camel@localhost>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 November 2005 16:17, Kasper Sandberg wrote:
>On Sun, 2005-11-20 at 18:58 -0500, Gene Heskett wrote:
>> On Sunday 20 November 2005 17:36, Kasper Sandberg wrote:
>> >On Sun, 2005-11-20 at 00:18 -0500, Gene Heskett wrote:
>> >> On Saturday 19 November 2005 22:40, Linus Torvalds wrote:
>> >> >There it is (or will soon be - the tar-ball and patches are still
>> >> >uploading, and mirroring can obviously take some time after
>> >> > that).
>> >>
>> >> First breakage report, tvtime, blue screen no audio.  Trying
>> >> slightly different .config for next build.  My tuner (OR51132)
>> >> seems to be permanently selected in an xconfig screen.  Dunno if
>> >> thats good or bad ATM.
>> >
>> >if it needs to be loaded with a parameter you will need to build it
>> > as a module.. my saa7134 chip needs card=9.
>>
>> Its never needed an argument before.
>
>then you have a good card, mine is a cheap cheap cheap one which
>apparently doesent have the nessecary embedded info to do proper
>autodetection, so i gotta manually specify which card i have.

Its a pcHDTV-3000

>> >i am experiencing same problems with saa7134, no video, however i do
>> > get audio.
>>
>> I wasn't, total digital gibberish on screen.
>>
>> A full powerdown reboot to 2.6.14.2 fixed it.
>>
>> >this is a way to (incorrectly according to v4l devs) "fix" it:
>> >drivers/media/video/video-buf.c
>> >change line 1233 to this:
>> >        vma->vm_flags |= VM_DONTEXPAND;

And this will actually do what?  Elaborate please.

I think my problem is that somehow, the dvb stuff now has a dependency
on the nxt200x thing, whatever it is, as if I force a kernel build
without it, then I get depmod problems at the end of the build telling
me:

WARNING:/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb
.ko needs unknown symbol nxt200x_attach.

This was never a requirement up thru 2.6.14.2, and I didn't try 15-rc1
as the -rc1's are usually a disaster of some kind, and this is also my
main box.  I don't need a filesystem muckup again.

So whatever did that seems in error to me, and should be backed out in
favor of some other method to bring in the nxt200x bearing cards.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

