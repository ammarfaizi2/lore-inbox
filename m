Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbTJZXTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 18:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbTJZXTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 18:19:16 -0500
Received: from cambridge.merl.com ([137.203.190.1]:60133 "EHLO
	cambridge.merl.com") by vger.kernel.org with ESMTP id S262907AbTJZXTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 18:19:14 -0500
Date: Sun, 26 Oct 2003 18:19:13 -0500
Message-Id: <200310262319.h9QNJDr13814@localhost.localdomain>
From: <wsy@merl.com>
To: marco.roeland@xs4all.nl
CC: linux-kernel@vger.kernel.org
In-reply-to: <20031026171650.GD23792@localhost> (message from Marco Roeland on
	Sun, 26 Oct 2003 18:16:50 +0100)
Subject: Re: compile-time error in 2.6.0-test9
References: <200310261553.h9QFrb513039@localhost.localdomain> <20031026162422.GB23792@localhost> <200310261635.h9QGZTe13121@localhost.localdomain> <20031026171650.GD23792@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   From: Marco Roeland <marco.roeland@xs4all.nl>

   [...]

   Just recently gcc 3.3.2 was released, so that or the latest from one's
   distribution is 'current' and should work fine. Be warned though that
   although they produce better code (and even that is sometimes disputed!)
   and give better warnings, compilation is a lot slower.

Yeah, I saw that on the GCC homepage.  Not sure if that's the way to go,
as it only went out like a week ago.

   The Linux kernel has a lot of handcrafted optimised code, so no gcc
   version is going to outsmart that easily anyway, and also very important
   is the amount of testing a kernel gets. Better a somewhat less optimal
   compiler but which has had a lot of testing, and so has it bugs known
   and 'workarounded', than a potential 'flyer' with unknown new bugs.

   But for userspace applications I'd recommend gcc 3.x wholeheartedly,
   for g++ especially.

I'm still in straight C mode.

Now, to figure out why I've got a bunch of unresolved symbols in 
when I do "make modules_install".

I am beginning to suspect that there's a particular bit of sequence that
I'm not doing quite right.  

It's:

	make  
	make bzImage
	make install
	make modules
	make modules_install

and I've read the obvious things on the kernel.org web page and
googled, even manually created /lib/modules/2.6.0-test9, but failed
to achieve enlightenment.

Any suggestions?  I've looked into upgrading to GCC 3.mumble, but that
looks to be a bit of an adventure unless I want to upgrade *everything*
as well.

    -Bill Yerazunis




