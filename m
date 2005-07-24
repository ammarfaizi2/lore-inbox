Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVGXQka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVGXQka (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 12:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVGXQka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 12:40:30 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:29389 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261395AbVGXQk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 12:40:28 -0400
Date: Sun, 24 Jul 2005 18:40:25 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: xor as a lazy comparison
Message-ID: <Pine.LNX.4.61.0507241835360.18474@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,


I have seen this in kernel/signal.c:check_kill_permission()

            && (current->euid ^ t->suid) && (current->euid ^ t->uid)

If current->euid and t->suid are the same, the xor returns 0, so these 
statements are effectively the same as a !=

	current->euid != t->suid ...

Why ^ ?


Jan Engelhardt
-- 
