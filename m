Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268995AbUJQCFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268995AbUJQCFh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 22:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268999AbUJQCFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 22:05:33 -0400
Received: from sa4.bezeqint.net ([192.115.104.18]:57261 "EHLO sa4.bezeqint.net")
	by vger.kernel.org with ESMTP id S268995AbUJQCFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 22:05:31 -0400
Date: Sun, 17 Oct 2004 04:06:33 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: lkml <linux-kernel@vger.kernel.org>
Subject: BUG [2.6.9-rc4] tmpfs is mountable even when not configured but non-functional
Message-ID: <20041017020633.GE5070@luna.mooo.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have tmpfs configured into my kernel

# CONFIG_TMPFS is not set

but I can still mount tmpfs, so mount -t tmpfs none /dev/shm works and I
get in the output of mount:

...
none on /dev/shm type tmpfs (rw)
...

when I try ls on that directory I get:

ls: /dev/shm/: Not a directory
