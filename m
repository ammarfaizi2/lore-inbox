Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbTILFUo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 01:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbTILFUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 01:20:44 -0400
Received: from [66.241.84.54] ([66.241.84.54]:1664 "EHLO bigred.russwhit.org")
	by vger.kernel.org with ESMTP id S261676AbTILFUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 01:20:43 -0400
Date: Mon, 8 Sep 2003 12:35:46 -0700 (PDT)
From: Russell Whitaker <russ@ashlandhome.net>
X-X-Sender: russ@bigred.russwhit.org
To: Ricky Beam <jfbeam@bluetronic.net>
cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: module char_10_135
In-Reply-To: <Pine.GSO.4.33.0309021727440.13584-100000@sweetums.bluetronic.net>
Message-ID: <Pine.LNX.4.53.0309030009380.183@bigred.russwhit.org>
References: <Pine.GSO.4.33.0309021727440.13584-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Sep 2003, Ricky Beam wrote:

> On Sat, 30 Aug 2003, Russell Whitaker wrote:
> >module-init-tools 0.9.13-pre 2
> >
> >That was the latest version I could find on Aug 3rd. Please let me know
> >if there is a later version I should try.
>
> Check the order of calls during boot.  In most cases, the rtc will be
> required before modules are setup -- /proc/sys/kernel/modprobe isn't
> set yet.

**update**  Had written the following and then updated to 2.6.0-test4-bk8
and found the module_char_10_135 problem has gone away.
  Thanks,
    Russ

Had changed "Enhanced Real Time Clock" from module to built-in so next
itteration will change it back and check it out. In the meanwhile here's
a recap of what I've done:

Started with a Slackware 9.0 installation, booting kernel 2.4.xx.
Custom kernel, these (amoung others) are modules: lp, floppy, and
"Enhanced Real Time Clock". Have this line in fstab so can mount floppy
as user:
  /dev/fd0   /mnt/floppy   auto   noauto,user

Everything works as expected. Then kernel-2.6 came out. So I "cp /vmlinuz
/vmlinuz.4", changed lilo's first entry to lin6, adding 2nd entry lin4,
installed lilo, edited lilo.config to change the 2nd vmlinuz to vmlinuz.4
and recycled lilo.

