Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWIMBSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWIMBSF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWIMBSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:18:05 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:5338 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1751466AbWIMBSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:18:01 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: R: Linux kernel source archive vulnerable
Date: Wed, 13 Sep 2006 01:17:48 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ee7m7r$6qr$1@taverner.cs.berkeley.edu>
References: <20060907182304.GA10686@danisch.de> <Pine.LNX.4.61.0609121619470.19976@chaos.analogic.com> <ee796o$vue$1@taverner.cs.berkeley.edu> <45073B2B.4090906@lsrfire.ath.cx>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1158110268 7003 128.32.168.222 (13 Sep 2006 01:17:48 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Wed, 13 Sep 2006 01:17:48 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Scharfe  wrote:
>[details on how GNU tar works, snipped]

Again, you miss my point.  I already know how tar works, but that's not
my point.  Why is it that people are so unwilling to address the real
issue here?  Let's try a few facts:

    (a) The Linux kernel tar archive contains files with world-writeable
    permissions.

    (b) There is no need for those files to have world-writeable
    permissions.  It doesn't serve any particular purpose.  If the
    permissions in the tar archive were changed to be not world-writeable,
    no harm would be done.

    (c) Some users may get screwed over by virtue of the fact that those
    files are listed in the tar archive with world-writeable permissions.
    (Sure, if every user was an expert on "tar" and on security, then
    maybe no one would get screwed over.  But in the real world, that's
    not the case.)

    (d) Consequently, the format of the Linux kernel tar archive is
    exposing some users to unnecessary riskis.

    (e) The Linux kernel folks could take a quick and easy step that
    would eliminate this risk.  That step would involve storing the
    files in the tar archive with permissions that were more reasonable
    (not world-writeable would be a good start!).  This step wouldn't
    hurt anyone.  There's no downside.

    (f) Yet the Linux kernel folks refuse to take this step, and any
    time someone mentions that there is something the Linux kernel folks
    could do about the problem, someone tries to change the topic to
    something else (e.g., complaints about bugs in GNU tar, suggestions
    that the user should invoke tar with some other option, claims that
    this question has been addressed before, you name it).

So why is it that the tar archive is structured this way?  Why are
the Linux kernel folks unnecessarily exposing their users to risk?
What purpose, exactly, does it serve to have these files stored with
world-writeable permissions?

Folks on the Linux kernel mailing list seem to be reluctant to admit these
facts forthrightly.  The posts I've seen mostly seem to have little or
no sympathy for users who get screwed over.  The attitude seems to be:
if you get screwed over, it's your fault and your problem.  Why is that?
If there is a simple step that Linux developers can take to eliminate
this risk, why is there such reluctance to take it, and why is there
such eagerness to point the finger at someone else?

The way I see it, storing files in a tar archive with world-writeable
permissions is senseless.  Why do such a strange thing on purpose?

It all seems thoroughly mysterious to me.
