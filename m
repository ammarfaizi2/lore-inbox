Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264969AbSK1ARp>; Wed, 27 Nov 2002 19:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264972AbSK1ARp>; Wed, 27 Nov 2002 19:17:45 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:33161 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264969AbSK1ARo>; Wed, 27 Nov 2002 19:17:44 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 27 Nov 2002 16:22:25 -0800
Message-Id: <200211280022.QAA07835@baldur.yggdrasil.com>
To: david-b@pacbell.net
Subject: Re: [PATCH] Module alias and table support
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
>Adam J. Richter wrote:
>> On Wed, Nov 27, 2002 at 01:53:58PM -0800, David Brownell wrote:
>> 
>>>One of the points being that the breakage comes from changing the
>>>format supported by modutils.  Restoring current functionality should
>>>IMO be high on the agenda .... USB has worked poorly in normal .configs
>>>for a while now, because of this.
>> 
>> 
>> 	I posted a patch a couple of days ago to revert 2.5.49/x86 to
>> user level modules (no modversions or gplonly symbols in this version
>> though).  However, I can't find the patch on marc.theaimsgroup.com, so
>> here it is again.

>Thanks, but I was hoping for a less radical solution:  just fixing
>the "no device table support" bug fixed in the latest modutils ... I
>do like the idea of forward motion in the module support, except that's
>not what we've seen so far with modutils.

	2.5.49 contains exports device ID tables again.  I think the
existing depmod would work, except for some problem that Rusty found
where it tries to use the kernel module interface (it really shouldn't
care what operating system you're running as it should just read and
write files).  Fix that depmod bug(?) and you should be happy, at
least until the next set of module patches (and if you don't use
"modprobe -c", module options, etc., all of which Rusty seems to be
working on).


>Seems like one of the issues is that there's really no maintainer
>for modutils lately.  And I'm not even sure where to get the latest
>modutils (more recent than 0.7) even if I were ready to patch them.

	ftp://ftp.kernel.org/pub/linux/utils/kernel/modutils/v2.4/

	I am running modutils-2.4.21, although I see that there is
a 2.4.22.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
