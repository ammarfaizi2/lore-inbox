Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTJLEYr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 00:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263422AbTJLEYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 00:24:47 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:15537 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S263418AbTJLEYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 00:24:45 -0400
Message-ID: <28fe01c39078$a4c0a630$5cee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <Valdis.Kletnieks@vt.edu>
Cc: <linux-kernel@vger.kernel.org>
References: <228201c38fd6$32b82c90$5cee4ca5@DIAMONDLX60> <200310111443.h9BEhr6s022474@turing-police.cc.vt.edu>
Subject: Re: 2.6.0-test7 + X11 + screen savers vs. user 
Date: Sun, 12 Oct 2003 13:22:44 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis Kletnieks replied to me:

>> In 2.6.0-test1 through test7, when running X11, the screen saver kicks in
>> about every 5 minutes.  I haven't checked the configuration but have
>> confidence that it's obeying the timing correctly.  The problem is that
>> it doesn't care whether the keyboard and mouse have been used during
>> that time.
>
> Which screen saver is this?

In SuSE 8.2, KDE's configuration panel, it is "random".  It was installed
that way by default during installation (at least when X11 and KDE defaults
are installed by default).  The list of possible screen savers is too long
to copy by hand, but anyway it doesn't seem to matter which one gets
randomly selected.  Under kernel 2.6.0-test1 through test7, the portion of
KDE or X11 that is supposed to be informed of keyboard or mouse activity
doesn't seem to be informed.  The screen saver kicks in every 4 minutes
according to KDE's configuration panel, which was also the default, and my
estimate of 5 minutes was before looking at the settings.

> jwz's xscreensaver 4.13 mostly works for me with XFree86 4.3.0, and
> notices keyboard activity and mouse cursor movement, but fails to detect
> mouse button events - so if you're in a mail program and reading a lot of
> mail and hitting 'delete' over and over, the screensaver can kick in
> anyhow.

Originally I thought I was observing something like this, but then watched
more closely and it is broader.  Mouse cursor movement is indeed being
ignored.  I'm almost certain that keyboard input is also being ignored, but
maybe should conduct another test while watch watching.

> I have to admit I've not tracked down if this is xscreensaver's fault, or
> the X server's fault, or the kernel's fault.

Under kernels 2.4.20, 2.4.19, and 2.4.18, I did not observe such a problem.
The screen saver only kicked in after a period of inactivity.  However, the
communication failure among the kernel, X11, KDE, etc., might not
necessarily be the kernel's fault, if other components were depending on
some characteristic of the 2.4 series which was undocumented or deprecated
in 2.4 and/or intentionally removed in 2.6.

