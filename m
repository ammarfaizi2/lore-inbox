Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263968AbTJ1Ne4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 08:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbTJ1Ne4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 08:34:56 -0500
Received: from catv-50624ad9.szolcatv.broadband.hu ([80.98.74.217]:13186 "EHLO
	catv-50624ad9.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S263968AbTJ1Nez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 08:34:55 -0500
Message-ID: <3F9E707B.7030609@freemail.hu>
Date: Tue, 28 Oct 2003 14:34:51 +0100
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.4.1) Gecko/20031024
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Autoregulate vm swappiness cleanup
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch makes my system even more responsive,
I applied the patch over 2.6.0-test8-mm1.

I have a Glade v1 project that has these source files among others:

$ ls -l callbacks.[ch] interface.[ch]
-rw-rw-r--    1 zozo     zozo       583241 okt 28 13:06 callbacks.c
-rw-rw-r--    1 zozo     zozo        96592 okt 27 22:54 callbacks.h
-rw-rw-r--    1 zozo     zozo      1090912 okt 27 22:54 interface.c
-rw-rw-r--    1 zozo     zozo         1687 okt 27 22:54 interface.h

That said, among others: the projects is *very* large, and is reasonably
modularised before someone says something silly about my programming
capabilities. :-)

gcc-3.3.2 (latest Fedora packages) goes up 160M+ in memory usage,
For a test run I started mozilla with some very long pages, oowriter,
gedit with the listed files opened and some gnome-terminal and a new project
compile with make -j2 so the callbacks.c and interface.c were compiled
simultaneously.

The system is a dual PIII/500 MHz with 512M RAM, not a speedy machine.
With all these, the system used only ~36M swap. Free memory was about 3-6M
then I exited oowriter. Free mem suddenly went up to 75M+, starting
programs was almost instant.

Definitely a win.

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.

