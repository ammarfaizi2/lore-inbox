Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbTEGN6y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 09:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbTEGN6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 09:58:54 -0400
Received: from siaag1af.compuserve.com ([149.174.40.8]:6842 "EHLO
	siaag1af.compuserve.com") by vger.kernel.org with ESMTP
	id S263202AbTEGN6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 09:58:53 -0400
Date: Wed, 7 May 2003 10:08:37 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Problem: strace -ff fails on 2.4.21-rc1
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305071011_MC3-1-37CE-FD16@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Is this a bug or a feature?  Machine only has 1 CPU, if that makes
any difference:


# strace -q -o minicom.trc -tt -ff minicom
upeek: ptrace(PTRACE_PEEKUSER, ... ): Operation not permitted
detach: ptrace(PTRACE_CONT, ...): Operation not permitted
Device /dev/ttyS1 lock failed: No child processes.
# uname -a
Linux d2 2.4.21-rc1 #1 SMP Wed May 7 06:05:31 EDT 2003 i686 unknown


  (Ignore that minicom error message about the lock failing -- that's
a separate problem...)


