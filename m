Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264693AbUD1Irm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264693AbUD1Irm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 04:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264697AbUD1Irm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 04:47:42 -0400
Received: from math.ut.ee ([193.40.5.125]:4547 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264693AbUD1Irl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 04:47:41 -0400
Date: Wed, 28 Apr 2004 11:42:54 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: New ide-proc warning from min/max changes
Message-ID: <Pine.GSO.4.44.0404281137480.24906-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.6.6-rc3 on a sparc64. This warning has appeared with the
IDE min/max changes:

  CC      drivers/ide/ide-proc.o
drivers/ide/ide-proc.c: In function `proc_ide_write_settings':
drivers/ide/ide-proc.c:511: warning: comparison of distinct pointer types lacks a cast

The line in question is
len = min(p - start, MAX_LEN);
where p and start are pointers of type "const char *" and MAX_LEN is
#define MAX_LEN 30

-- 
Meelis Roos (mroos@linux.ee)


