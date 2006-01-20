Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWATIml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWATIml (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWATIml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:42:41 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:22681 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750734AbWATImk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:42:40 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.1.4
cc: linux-kernel@vger.kernel.org
Date: Fri, 20 Jan 2006 00:42:38 -0800
Message-ID: <7v1wz31e9t.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.1.4 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.1.4.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.1.4-1.$arch.rpm	(RPM)

This contains one minor fix and one performance fix.

----------------------------------------------------------------

Changes since v1.1.3 are as follows:

Johannes Schindelin:
      git-fetch-pack: really do not ask for funny refs

      * This fixes a case where "git-fetch-pack" is asked to
        fetch all the refs; git barebone Porcelain never
        triggers it and that is one reason why it was never
        noticed so far.

Junio C Hamano:
      Revert "check_packed_git_idx(): check integrity of the idx file itself."

      * This was causing significant performance degradation
        compared to 0.99.9x.  First noticed and complained by
        Andrew, and the bisect tool by Linus helped to pinpoint
        it.  I just took credit for what the two kernel titans
        did to help us ;-).

