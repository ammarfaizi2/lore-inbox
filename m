Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbUDSLgw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 07:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbUDSLgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 07:36:51 -0400
Received: from spc1-brig1-3-0-cust85.lond.broadband.ntl.com ([80.0.159.85]:7093
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S264360AbUDSLgb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 07:36:31 -0400
Date: Mon, 19 Apr 2004 12:36:30 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: KVM issues with recent 2.6 kernels
Message-ID: <Pine.LNX.4.58.0404191216020.31750@ppg_penguin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I'm seeing some oddities on two 2.6 boxes here.  I use a Belkin Omni
4-way PS/2 KVM switch.  It has a "hot key" to switch boxes (scroll-lock
twice, then number 1-4).  This has always been a little problematic on
2.4 (you have to get the timing of the key presses right, worst case
when you get to the session either the number has been treated as input,
or the display has scroll-lock turned on), but usable.

 On the two boxes running 2.6 (Celeron 1GHz with 2.6.4, Duron 1GHz with
2.6.5) I'm now seeing two strangenesses:

 The celeron is running console sessions, including a long-winded series
of shell scripts run from a Makefile.  I've started to notice that if I
start the make then switch to another machine, sometimes when I come
back the build is "stalled" between the scripts - the console looks as
if scroll-lock is on, but when I free it the next stage of the build
starts (confirmed from `top').  My expectation is that the whole build
would have continued, even if that particular console display was
somehow "locked".

 The duron is now being used to do things in xterms.  From time to time
the alt key stops being recognised (no alt-tab to switch windows, no
ctrl-alt-n to switch desktops).  And then after again switching machines
it suddenly starts working properly again.

 Any suggestions on where to look, or which parts of my .config would be
relevant ?

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

