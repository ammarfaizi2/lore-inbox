Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265651AbTFNI4X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 04:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbTFNI4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 04:56:23 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:22154 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S265651AbTFNI4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 04:56:22 -0400
Date: Sat, 14 Jun 2003 10:10:14 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: EFS breakage in 2.5
Message-ID: <20030614091014.GA18188@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current bk oopses during initialisation of EFS.

EFS: 1.0a - http://aeschi.ch.eu.org/efs/
-----------[ cut here ]-------------
kernel BUG at mm/slab.c:981!
invalid operand: 0000 [#1]
CPU: 0
EIP: 0060:[<c0144401>] Not tainted
EFLAGS: 00010202
EIP is at kmem_cache_create+0x12c/0x685
...
Call Trace:
 init_inodecache
 init_once
 init_efs
 do_initcalls
 init_workqueues
 init
 init
 kernel_thread_helper

<0> kernel panic: Attemped to kill init!

