Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWJEPmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWJEPmj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWJEPmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:42:39 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:12930 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S932144AbWJEPmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:42:38 -0400
Date: Thu, 05 Oct 2006 11:41:49 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Merge window closed: v2.6.19-rc1
In-reply-to: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
To: linux-kernel@vger.kernel.org
Message-id: <200610051141.50018.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 October 2006 23:29, Linus Torvalds wrote:
>Ok, it's two weeks since v2.6.18, and as a result I've cut a -rc1
> release.
>
>As usual for -rc1 with a lot of pending merges, it's a huge thing with
>tons of changes, and in fact since 2.6.18 took longer than normal due to
>me traveling (and others probably also being on vacations), it's possibly
>even larger than usual.
>
>I think we got updates to pretty much all of the active architectures,
>we've got VM changes (dirty shared page tracking, for example), we've got
>networking, drivers, you name it. Even the shortlog and the diffstats are
>too big to make the kernel mailing list, but even just the summary says
>something:
>
> 4998 total commits
> 6535 files changed, 414890 insertions(+), 233881 deletions(-)
>
>so please give it a good testing, and let's see if there are any
>regressions.
>
>As usual, the best way to get some grip on a particular subsystem would
>tend to be with some script like
>
> git log --no-merges v2.6.18.. drivers/usb | git shortlog | less -S
>
>which gives a more manageable overview of any particular area you're
>interested in (in the example that would be 'drivers/usb', but you can
>use this to browse any interesting area).
>
>   Linus

I had to rebuild it 2 extra times to get all the options right, partially 
my fault.  But once my usual .config was achieved, it back to business as 
usual, complete with my logs being littered with this message:

Oct  5 11:14:40 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3

This is my only (so far) minor nit to pick.

[root@coyote linux-2.6.19-rc1]# lsusb
[...]
Bus 003 Device 003: ID 045e:008c Microsoft Corp.
[...]

Now, I'd assume its referring to my mouse, the Microsoft Corp entry above, 
which has had a fresh set of batteries installed without effecting this, 
and I even removed the batteries from another usb/bluetooth mouse I use on 
my lappy when its powered up, all without effecting this apparently 
innocuous error as the mouse itself works just fine.  The receiver is 
about 3 feet away as the tower is at least 5 feet away, under an adjacent 
desk.

This started at about the same time I jumped from a 2.6.16-something to the 
2nd rc of 2.6.18, and has continued more or less un-abated since.  Doing a 
reset/reconfigure on the mouse and base station does not appear to 
generate any log messages, nor to effect the random logging of the above 
messages.

Does anyone have a suggestion?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
