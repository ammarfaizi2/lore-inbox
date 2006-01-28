Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWA1Esg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWA1Esg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 23:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWA1Esg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 23:48:36 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:61587 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932515AbWA1Esf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 23:48:35 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.1.5
cc: linux-kernel@vger.kernel.org
Date: Fri, 27 Jan 2006 20:48:33 -0800
Message-ID: <7virs5x8im.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.1.5 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.1.5.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.1.5-1.$arch.rpm	(RPM)

Mark Wooding noticed that there is a bug in git-checkout-index
to overflow its internal buffer, if you construct a blob that
records an insanely long symbolic link in your index file and
try to check it out.  This makes it dump core or worse.  

The fix for this problem is the only change from v1.1.4.  The
master branch has been updated with the same fix (so has "pu").


---

By the way, "dump core or worse" is a subtle way to say that
this is a security fix.  To be victimized, you have to somehow
first get such a bogus symbolic link in your index.  Merging
with somebody of dubious trustworthiness is a way to do so;
please practice safe merge ;-).

