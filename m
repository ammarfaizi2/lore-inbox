Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261575AbSJMSpL>; Sun, 13 Oct 2002 14:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbSJMSpL>; Sun, 13 Oct 2002 14:45:11 -0400
Received: from [195.39.17.254] ([195.39.17.254]:7940 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261575AbSJMSpI>;
	Sun, 13 Oct 2002 14:45:08 -0400
Date: Sun, 13 Oct 2002 20:38:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: in_atomic() & spin_lock / spin_unlock in different functions
Message-ID: <20021013203838.A122@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

What is it that in_atomic counts? Obviously spinlocks and
get_cpu/put_cpu. Anything else?

Is there easy way to find out which spinlock causes "scheduling in
atomic" warning? [It happens a *lot* in swsusp].

I'm doing spin_lock_irqsave() then in another function
spin_unlock_irqrestore. Is that okay? If no, can it cause "scheduling
in atomic"?
								Pavel
-- 
When do you have heart between your knees?
