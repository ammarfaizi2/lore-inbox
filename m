Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTJLWa7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 18:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbTJLWa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 18:30:59 -0400
Received: from neors.cat.cc.md.us ([204.153.79.3]:44233 "EHLO
	student.ccbc.cc.md.us") by vger.kernel.org with ESMTP
	id S261193AbTJLWa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 18:30:58 -0400
Date: Sun, 12 Oct 2003 18:26:24 -0400 (EDT)
From: John R Moser <jmoser5@student.ccbc.cc.md.us>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Need help with compressed page cache
Message-ID: <Pine.A32.3.91.1031012181545.25312A-100000@student.ccbc.cc.md.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The linuxcompressed-devel list at sourceforge is nonresponsive (I'm talking
to myself on there) right now it seems.  I've been trying to continue the
work of Rodrigo Castro at linux-compressed.sf.net for the past few days just
a bit, mainly I'm just trying to do a quick rewrite to allow more than one
algorithm to be used at a time (i.e. so the alg can be switched on-the-fly
without having to reencode all compressed pages).  Check the archive at
http://sourceforge.net/mailarchive/forum.php?forum_id=2050 to see what I'm
doing. 

At any rate, i'm having trouble.  It seems to compress just fine, but 
when i get to decompressing a page, it now crashes.  I've had the kernel 
spit out several oopses or something on my screen about not being able to 
handle a paging request at some virtual address.  I can't debug it and 
I'm starting to insert dirty hacks.  I'm a newbie at this, can i get some 
help?

What I'm really looking for is a quick hand-out.  Somebody figure out 
what's wrong, how to fix it, TELL ME (important thing this:  I won't 
learn if you just go around cleaning up after my screw-ups) what I 
screwed up, and give me the fixed code.  Once it works I'll continue to 
divide the code out away from the core, and set it up so that each 
compression algorithm registers with the core on initialization.  I 
should be able to make it so that the alg can be set with a sysctl while 
running WITHOUT crashing (yes I've found the sysctl code on my own, no I 
don't understand it but I'll figure it out; you don't have to hold my 
paw you know).

Any takers?  If you want to help, contact me directly at this e-mail 
address.  Meanwhile I'll blindly hammer it and try not to do more damage 
that I've already done ^_^;

--Bluefox Icy
