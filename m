Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbUK2TAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUK2TAO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbUK2TAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:00:13 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:34234 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261519AbUK2Syw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 13:54:52 -0500
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Rik van Riel <riel@redhat.com>,
       Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: [PATCH] CKRM: 0/10 Class Based Kernel Resource Management
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19600.1101753889.1@us.ibm.com>
Date: Mon, 29 Nov 2004 10:44:49 -0800
Message-Id: <E1CYqW1-00056B-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following ten patches add the core of CKRM (Class Based Resource
Management) to Linux.  Current patches are against 2.6.10-rc2.  This
set of patches is essentailly a cleaned up version of what is
known on the ckrm-tech@lists.sourcerforge.net as the E16 code base.
As compared to E16, the patch breakout has been reorganized for easier
application to mainline with a number of stylistic cleanups more
in line with mainline kernel code.

The following patches include:

01-diff_ckrm_events:
	Base CKRM events, mods to existing kernel code

02-diff_delay_acct:
	More accurate accounting for CPU scheduling, IO scheduling

03-diff_ckrm_core:
	Main/core CKRM code, beginings of Resource Control Filesystem

04-diff_rcfs:
	Full directory suppport for rcfs

05-diff_taskclass:
	Task based management for CPU, memory and Disk I/O.

06-diff_sockclass:
	CKRM tracking for socket classes for inbound connection control,
	bandwidth control, etc.

07-diff_numtasks:
	Resource controller for number of tasks per class.

08-diff_listenaq:
	Resource Controller for prioritizing inbound connection
	requests.  Can control queue weights for multiple accept
	queues.

09-diff_rbce
	A very basic rules based classification engine for automatically
	adding tasks to classes.  Also includes an enhanced rules based
	classification engine with better per-process delay data and
	ability to better monitor class related activities.

10-diff_docs
	CKRM documentation.

Please send comments to ckrm-tech@lists.sourceforge.net

thanks,

gerrit
