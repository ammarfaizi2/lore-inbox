Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbUAVSPg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 13:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266343AbUAVSPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 13:15:36 -0500
Received: from defout.telus.net ([199.185.220.240]:12437 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S264893AbUAVSPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 13:15:34 -0500
Subject: Re: Nvidia drivers and 2.6.x kernel
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1074795332.3880.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 22 Jan 2004 11:15:32 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I also have an Nvidia Ti4200, running on Fedora Core with the
2.6.2-rc1 kernel.  The easiest way to get the driver installed was to
grab a pre-built no-fuss installer from
http://www.sh.nu/download/nvidia/linux-2.6/ and after you build your new
kernel, boot into it, kill X and make sure it stays dead by modifying
/etc/inittab by changing 
respawn:/etc/X11/prefdm -nodaemon
to
# x:5:respawn:/etc/X11/prefdm -nodaemon
(save) and type init q  ...if X wasn't dead before, it is now.  You
should now be able to install the driver (where ever you put it) by just
running >sh <drivername>
Assuming your XF86Config is still setup to deal with the binary nVidia
driver, when you uncomment the line in the /etc/inittab file and re-run
init q, X should start with an nvidia splash screen.  Please be aware
that there are problems with agpgart on via chipsets (I don't have one,
I'm quoting from the minion page).  And there is a procedure for getting
mesa (and optionally glut) installed alongside the binary nvidia driver
(and a bit more if you want tv with overscan).  

