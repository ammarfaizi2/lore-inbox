Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSKHSTl>; Fri, 8 Nov 2002 13:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261563AbSKHSTk>; Fri, 8 Nov 2002 13:19:40 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:55035 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261561AbSKHSTk> convert rfc822-to-8bit; Fri, 8 Nov 2002 13:19:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Jens Axboe <axboe@suse.de>
Subject: Whither the "system without /proc" crowd?
Date: Fri, 8 Nov 2002 18:26:16 +0000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <32851.62.65.205.175.1036691341.squirrel@webmail.starman.ee> <20021108114318.GX32005@suse.de> <20021108135849.GZ32005@suse.de>
In-Reply-To: <20021108135849.GZ32005@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211081826.16168.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 November 2002 13:58, Jens Axboe wrote:

> Here's a patch that includes that feature, puts the tunables in sysfs
> (so you obviously need that mounted). In
>
> /sys/block/<disk>/iosched

Stupid question time:

A great deal of text has been expended over the years by people desperately 
trying to make sure you didn't need /proc mounted to have a usable system, 
for some definition of usable.  Now with rootfs, initramfs, sysfs, and the 
libfs inspired "make a filesystem rather than an ioctl" policy, the main 
argument against requiring the use of /proc is that it has a lot more gunk in 
it (left over from the days when it was the only ramfs type system to export 
values in) than anyone is comfortable with.  (The argument against /dev/pty 
largely seems to be inertia, now that the "number of ptys" issue as a config 
tunable seems to have been cleared up).

There seems to be some sort of nebulous plan for eventually stripping down 
/proc, perhaps making a "crapfs" that's a union mount on top of /proc 
providing deprecated legacy support for a release or two.  But I haven't 
heard it explicitly stated.

So my questions are:

1) will some subset of /proc, /sys, /dev/pty, etc become required at some 
point in the future on everything but the most customized embedded systems?  
Or is keeping the system usable without them still a goal?

2) Is there a plan to rehabilitate /proc?

(I ask because I don't know.  Maybe I missed some important posts...)

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
