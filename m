Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbTI2J6w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 05:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbTI2J6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 05:58:52 -0400
Received: from catv-50624ad9.szolcatv.broadband.hu ([80.98.74.217]:17284 "EHLO
	catv-50624ad9.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S262947AbTI2J6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 05:58:49 -0400
Message-ID: <3F780255.6010408@freemail.hu>
Date: Mon, 29 Sep 2003 11:58:45 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.2.1) Gecko/20030225
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Havoc Pennington <hp@redhat.com>
Subject: Re: 2.6.0-test6-mm1
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying it out on a RH9. It compiled and seems
to run nicely.

However, there is a problem that annoys me enough now to report.
This is a problem for some time now, it is not a new one.
But it seems to be a problem outside the kernel, read on.

Have you tried to run "make menuconfig" on a 2.6.0testX
in a gnome-terminal?

It gets stuck, not always, but very often. The exact problem
is that on a menu draw (e.g. on entering a submenu or going
one level up) the gnome-terminal window is cleared (everything
is repainted with the background color) but the newly selected
menu does not appear.

gnome-terminal starts (or tries to start) eating 100% CPU,
starting another terminal window succeeds and runnig pstree in
it shows this (I left the pids out):

|-gnome-terminal---bash---pstree
|                |-bash---make---make---mconf---lxdialog
|                |-gnome-pty-helper

Running kernel[-smp]-2.4.20-20.9 it does not happen.
Closing the stuck window, the CPU usage drops.

"LD_ASSUME_KERNEL=2.2.5 make menuconfig" produces the same
result.

I am cc-ing Havoc Pennington (I found his address in
gnome-terminal's About dialog), he may know where to fix or
he can confirm that a newer gnome-terminal is already fixed.
Using "make menuconfig" in a plain or color xterm, in Konsole
or in the console, the problem does not occur.

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.


