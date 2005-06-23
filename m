Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVFWGWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVFWGWw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVFWGTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:19:40 -0400
Received: from [24.22.56.4] ([24.22.56.4]:3046 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262234AbVFWGSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:35 -0400
Message-Id: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:15:52 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net
Subject: [patch 00/38] CKRM e18:  Updated core patches to 2.6.12 and included e17 changes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--

Here are the core patches for CKRM updated to 2.6.12, along with the most
basic classification engine and a slightly more advanced derivative,
several bug fixes to the core code, and all of the changes contained
in what the CKRM e17 base.  Thus this version in the CKRM world will be
referred to as e18.  It should be functionality equivalent to the e17
patch set in terms of overall capabilities - just cleaned and ported to
2.6.12.

All of these changes have been tested on IA32 and PPC64, with CONIG_CKRM
on and off, including both basic functionality tests and a variety of
stress/performance tests using the same harness as mjbligh's current
regression tests.

Upcoming patches (soon to be included) are the memory controller (parts of
which are being currently discussed on linux-mm), the listen accept
queue and an IO contoller (or maybe two).

Andrew, I believe at this point these are ready for additional testing and
review that your -mm tree brings.  Comments on the last major posting were
very minimal.  There are more changes pending on the ckrm-tech mailing list
which I'll bring forward soon as well.

Here is the current series file:

01-diff_ckrm_events
02-diff_delay_acct
03-diff_ckrm_core
04-diff_rcfs
05-diff_taskclass
06-diff_sockclass
07-diff_numtasks
10-diff_docs
03a-missing_unlock
06a-ckrm_net_cb
06b-ckrm_sockc
07a-numtasks_config
07c-numtasks_cleanup
07c2-numtasks-undo-delete
09-01-rbce_fs
09-02-rbce_fs-main
09-03-rbce_main-opt
09-04-rbce_opt-core
09-05-rbce_core-crbce
ckrm-printf-cleanup
compiler-warning-fix

# e17 patch set
ckrm-utils
rbce_modcount_incorrect
ckrm-numtasks_config
ckrm-numtasks_forkrate
ckrm-ce_modules
ckrm-rbce-rmclass
ckrm-inittask
ckrm-remove_target
use_sizeof_instead_of_define_for_the_array_size_in_taskclass
ckrm-rbce_class_del_crash
ckrm-inc-taskdelay
ckrm-jiffies_to_msec-modified
ckrm-fix_compile_warnings_del_dead_code-modified
ckrm-numtasks_lockfix
ckrm-ce-config

# rbce cleanups

use_sizeof_instead_of_define_for_the_array_size_in_rbce

# merge fix

target_fileops_fix

--
gerrit
