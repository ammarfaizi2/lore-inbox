Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbTLCItV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 03:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbTLCItV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 03:49:21 -0500
Received: from fmr06.intel.com ([134.134.136.7]:11730 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264512AbTLCItU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 03:49:20 -0500
Date: Wed, 03 Dec 2003 00:51:09 -0800
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN Realtime & Robust mutexes for Linux try 2
Message-ID: <0312030051.PbYaFa~d8c8cGbebAaFaPbibda2c0cgd25502@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

This code proposes an implementation of kernel based mutexes,
taking ideas from the actual implementations using futexes
(namely NPTL), intending to solve its limitations (see doc)
and adding some features, such as real-time behavior,
priority inheritance and protection, deadlock detection and
robustness.

Please look at the first patch, containing the documentation
for information on how is it implemented.

The patch is split in the following parts:

1/10: documentation files
2/10: modifications to the core
3/10: Support for i386
4/10: Support for ia64
5/10: kernel fuqueues
6/10: user space/kernel space tracker
7/10: user space fuqueues
8/10: kernel fulocks
9/10: stub for priority protection
10/10: user space fulocks

We have a site at http://developer.osdl.org/dev/robustmutexes
with references to all the releases, test code and NPTL
modifications (rtnptl) to use this code. As well, the patch
is there in a single file, in case you don't want to paste
them manually.

