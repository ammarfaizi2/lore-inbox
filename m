Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWIMTTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWIMTTX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWIMTTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:19:23 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:54449 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751138AbWIMTTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:19:22 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.4.2.1
cc: linux-kernel@vger.kernel.org
Date: Wed, 13 Sep 2006 12:19:21 -0700
Message-ID: <7vsliv8thi.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.4.2.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.2.1.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.2.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.2.1.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.2.1-1.$arch.rpm	(RPM)

This release is primarily for these two fixes:

 * git-mv was broken.  Notably, this did not work:

	git-mv foo foo-renamed

 * git-http-fetch failed to follow objects/info/alternates on
   the remote side.  This broke a fetch from Paul's powerpc.git
   repository.

I have built i386 and x86_64 RPM this time, since the machine I
do the former has become available again.

----------------------------------------------------------------

Changes since v1.4.2 are as follows:

Dennis Stosberg:
      Solaris does not support C99 format strings before version 10

Johannes Schindelin:
      git-mv: succeed even if source is a prefix of destination
      git-mv: add more path normalization
      git-mv: special case destination "."
      git-mv: fix off-by-one error
      builtin-mv: readability patch

Junio C Hamano:
      finish_connect(): thinkofix
      http-fetch: fix alternates handling.

Luben Tuikov:
      Fix regex pattern in commit-msg
      sample commit-msg hook: no silent exit on duplicate Signed-off-by lines

