Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132465AbRCaRRk>; Sat, 31 Mar 2001 12:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132468AbRCaRRb>; Sat, 31 Mar 2001 12:17:31 -0500
Received: from venus.postmark.net ([207.244.122.71]:27153 "HELO
	venus.postmark.net") by vger.kernel.org with SMTP
	id <S132465AbRCaRRT>; Sat, 31 Mar 2001 12:17:19 -0500
Message-ID: <20010331174638.16806.qmail@venus.postmark.net>
Mime-Version: 1.0
From: J Brook <jbk@postmark.net>
To: Andrew Ferguson <andrew@owsla.cjb.net>
Cc: raffo@neuronet.pitt.edu, papadako@csd.uoc.gr, alan@clueserver.org,
   vandrove@vc.cvut.cz, linux-kernel@vger.kernel.org
Subject: Re: Matrox G400 Dualhead
Date: Sat, 31 Mar 2001 17:46:38 +0000
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a similar problem with my G450, booting into the framebuffer,
> then loading xdm and working in X, and then switching back to the 
> console. I may have another detail to add in that when I switch back
> to the console from X, my monitor blanks and displays the warning 
> that the frequencies are out of range.

 I think I have a work around. Boot up 2.4.3 with the framebuffer
enabled as normal. Log in as root and use the fbset program to change
the settings for all the framebuffers.
eg.

fbset -a 1024x768-70

or whatever works for you. fbset has its own man page.

This makes everything hunky-dory for me, in that after running fbset
I
can go in and out of X without ever losing the video signal.

 Petr, I had a look at the drivers/video/matrox subdir and there's no
difference between 2.4.2 and 2.4.3, however there are differences in
the drivers/video dir to do with framebuffers. The files that have
been changed in drivers/video/ are:
  creatorfb.c
  fbmem.c
  fonts.c
  modedb.c
  sbus.c

 I know nothing about the nature of the changes that have been made
though!

 It does seem to be a kernel problem rather than a X4.0.3 problem
seeing as how 4.0.3 works fine under 2.4.2, and that using fbset on
the framebuffer console in 2.4.3 solves the problem.

     John
----------------
jbk@postmark.net
