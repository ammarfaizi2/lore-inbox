Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbUAYXyU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265371AbUAYXyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:54:20 -0500
Received: from dp.samba.org ([66.70.73.150]:7819 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265362AbUAYXyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:54:16 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: piggin@cyberone.com.au
Cc: linux-kernel@vger.kernel.org
Subject: New NUMA scheduler and hotplug CPU
Date: Mon, 26 Jan 2004 10:50:36 +1100
Message-Id: <20040125235431.7BC192C0FF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick!

	Looking at your new scheduler in -mm, it uses cpu_online_map
alot in arch_init_sched_domains.  This means with hotplug CPU that it
would need to be modified: certainly possible to do, but messy.

	The other option is to use cpu_possible_map to create the full
topology up front, and then it need never change.  AFAICT, no other
changes are neccessary: you already check against moving tasks to
offline cpus.

Anyway, I was just porting the hotplug CPU patches over to -mm, and
came across this, so I thought I'd ask.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
