Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbTKDRUP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 12:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbTKDRUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 12:20:15 -0500
Received: from gaia.cela.pl ([213.134.162.11]:49672 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S262432AbTKDRUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 12:20:12 -0500
Date: Tue, 4 Nov 2003 18:20:06 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: VGA Console Idea
Message-ID: <Pine.LNX.4.44.0311041813320.5053-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this is just an idea for a VGA text mode console improvement which would
provide us with 512 char fonts with little functionality loss.

Basically we perform a bit inversion of the font bitmap, and then map
foreground to background and background to foreground.  If we turn off the
blink bit allowing high intensity background colours then we end up with
16 foreground colours, 8 background colours, no blink and no high
intensity background colours.  Since both blink and bg high intensity are
seldom used (since you can (not quite) never be sure if you'll get one or
the other) we end up with a 16fg/8bg/512char font situation.  Everything
works as expected except for direct memory access through vcs/vcsa, these
would need to be nibble swapped in the colour area, but then with 512 char
fonts these aren't exactly really supported anyway...  What do you think?

Cheers,
MaZe.

