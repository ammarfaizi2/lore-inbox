Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbSKHM4D>; Fri, 8 Nov 2002 07:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSKHM4D>; Fri, 8 Nov 2002 07:56:03 -0500
Received: from sub29-58.member.dsl-only.net ([63.105.29.58]:28800 "EHLO
	eaglet.rain.com") by vger.kernel.org with ESMTP id <S261861AbSKHM4C>;
	Fri, 8 Nov 2002 07:56:02 -0500
Message-Id: <200211081302.gA8D1io03168@eaglet.rain.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
reply-to: ricklind@us.ibm.com
Subject: Re: [PATCH] 2.5.46: duplicate statistics being gathered 
In-reply-to: Your message of "Thu, 07 Nov 2002 21:27:08 PST."
             <3DCB4B2C.989AA22@digeo.com> 
Date: Fri, 08 Nov 2002 05:01:43 -0800
From: Rick Lindsley <rick@eaglet.rain.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    The <unknown quantity of> applications out there which are reading
    the disk info from /proc/stat need to be taught to go fishing in
    /name-of-the-day-fs.

As we determine the quantity, I'm (so far) willing to assist in porting.

    So what do people think?  Do we just peremptorily nuke it and let
    the world catch up, or is a more organised migration possible?

We should set the new world order in place before 2.6 emerges.  That
allows distros to collect or create tools for their stable releases
which take advantage of this.

    Rick, I believe you've hunted down some other apps which are
    using this info. sysstat, sar, mpstat, various flavours of iostat.
    Where do we stand on getting those updated?

iostat.c from linux.inet.hr is almost completely ported now.  It will
search around in /proc/partitions, /proc/diskstat, and <sysfs>/block
to try to find the location of the statistics, meaning it should work
on 2.4 + patches, 2.5 + patches, now 2.5.46, and eventually 2.4, 2.5,
and 2.6 without patches.  IT'S NOT THERE YET -- still testing and hope
to pass it on to the site owner this weekend.

iostat.c and sar from the sysstat set of tools at
http://perso.wanadoo.fr/sebastien.godard/ has been gathered, perused,
but not yet ported.  The iostat.c source is similar but different from
the source mentioned above.  The sysstat tools will be next, and the
changes again passed back to the site maintainer.

If there are other tools that utilize disk statistics, now would be a
very good time to let me know about them.  I feel strongly enough about
getting this right to help port them as needed .. for a while anyway :)

In the kernel, there are some designated maintainers for many areas.
Is it similar in user space?

Rick
