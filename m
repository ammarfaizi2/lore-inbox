Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264038AbTKSTeW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 14:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbTKSTeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 14:34:22 -0500
Received: from pat.uio.no ([129.240.130.16]:32486 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264024AbTKSTeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 14:34:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16315.50617.410957.360925@charged.uio.no>
Date: Wed, 19 Nov 2003 14:34:17 -0500
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>
Subject: Further query about locks_remove_posix()...
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does anybody know why this function is checking fl->fl_owner instead
of using the posix_same_owner() test (which also checks fl->fl_pid)?

In the case of CLONE_FILES, there is a significant difference between
the two.

Note: this question applies to both 2.4.x and 2.6.x...

Cheers,
  Trond
