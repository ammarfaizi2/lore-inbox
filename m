Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135625AbRD1URa>; Sat, 28 Apr 2001 16:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135626AbRD1URU>; Sat, 28 Apr 2001 16:17:20 -0400
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:24075 "HELO
	mail.cvsnt.org") by vger.kernel.org with SMTP id <S135625AbRD1URN>;
	Sat, 28 Apr 2001 16:17:13 -0400
Subject: just-in-time debugging?
From: Tony Hoyle <tmh@nothing-on.tv>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution (0.9 - Preview Release)
Date: 28 Apr 2001 21:17:10 +0100
Mime-Version: 1.0
Message-Id: <20010428201708.E629E13F6A@mail.cvsnt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way (kernel or userspace... doesn't matter) that gdb/ddd
could be invoked when a program is about
to dump core, or perhaps on a certain signal (that the app could deliver
to itself when required).  The latter case
is what I need right now, as I have to debug an app that breaks
seemingly randomly & I need to halt when
certain assertions fail.  Core dumps aren't much use as you can't resume
them, otherwise I'd just force a segfault
or something.

I had a look at the do_coredump stuff and it looks like it could be
altered to call gdb in the same way that
modprobe gets called by kmod... however I don't sufficiently know the
code to work out whether it'd work properly
or not.  

A patch to glibc would perhaps be better, but I know that code even
less!

Something like responding to SIGTRAP would probably be ideal.

Tony

-- 

"Two weeks before due date, the programmers work 22 hour days cobbling an
 application from... (apparently) one programmer bashing his face into the
 keyboard." -- Dilbert

tmh@magenta-netlogic.com                http://www.nothing-on.tv 

