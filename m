Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbTIKEmY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 00:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266057AbTIKEmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 00:42:24 -0400
Received: from zok.SGI.COM ([204.94.215.101]:26583 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265993AbTIKEmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 00:42:18 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Local DoS on single_open?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Sep 2003 14:42:13 +1000
Message-ID: <3741.1063255333@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

single_open() requires the kernel to kmalloc a buffer which lives until
the userspace caller closes the file.  What prevents a malicious user
opening the same /proc entry multiple times, allocating lots of kmalloc
space and causing a local DoS?

