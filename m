Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264099AbTF3OEM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 10:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbTF3OEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 10:04:12 -0400
Received: from as6-4-8.rny.s.bonet.se ([217.215.27.171]:39684 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S264099AbTF3OEL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 10:04:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fredrik Tolf <fredrik@dolda2000.cjb.net>
To: linux-kernel@vger.kernel.org
Subject: PTY DOS vulnerability?
Date: Mon, 30 Jun 2003 16:18:36 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306301613.11711.fredrik@dolda2000.cjb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has someone considered PTYs as a possible attack vector for DOS 
attacks? Correct me if I'm wrong, but cannot someone just open 
all available PTYs on a console-less server and make everyone 
unable to log in?

I mean, what if eg. apache is hacked, and the first thing the 
attacker does is to tie up all PTYs, so that noone can log in to 
correct the situation while the attacker can go about his 
business? Then the only possible solution would be to reboot the 
server, which might very well not be desirable.

If you want proof of concept code, look at
http://www.dolda2000.cjb.net/~fredrik/ptmx.c
I successfully ran this on one of my servers which effectively 
disabled anyone from logging in via SSH.

Shouldn't PTYs be a per-user resource limit?

Someone must have thought of this before me, right? How am I 
wrong?

Fredrik Tolf

