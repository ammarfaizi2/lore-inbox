Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263042AbVG3L33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263042AbVG3L33 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 07:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbVG3L20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 07:28:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56960 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263042AbVG3L1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 07:27:43 -0400
Date: Sat, 30 Jul 2005 13:26:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/4] Task notifier against mm: Implement todo list in task_struct
Message-ID: <20050730112633.GA3081@elf.ucw.cz>
References: <Pine.LNX.4.62.0507291328170.5304@graphe.net> <Pine.LNX.4.62.0507291332100.5304@graphe.net> <20050730112241.GA1830@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730112241.GA1830@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Introduce a todo notifier in the task_struct so that a task can be told to do
> > certain things. Abuse the suspend hooks try_to_freeze, freezing and refrigerator
> > to establish checkpoints where the todo list is processed. This will break software
> > suspend (next patch fixes and cleans up software suspend).
> 
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 13
> EXTRAVERSION =-rc3-mm3
> 
> This patch fails:
> 
> pavel@amd:/usr/src/linux-mm$ cat /tmp/delme | patch -Esp1
> 1 out of 3 hunks FAILED -- saving rejects to file include/linux/sched.h.rej
> pavel@amd:/usr/src/linux-mm$

(Notice that I do not nice 4 patches with changelogs. One patch
against known-good version should be enough for testing.)
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
