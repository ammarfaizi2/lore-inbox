Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWDKK4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWDKK4q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 06:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWDKK4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 06:56:46 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:37046 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750735AbWDKK4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 06:56:46 -0400
Date: Tue, 11 Apr 2006 12:56:30 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: sys_tee
In-Reply-To: <20060411080705.GB3439@suse.de>
Message-ID: <Pine.LNX.4.61.0604111255010.928@yvahk01.tjqt.qr>
References: <20060411080705.GB3439@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Here follows an implementation of sys_tee. It works a little differently
>that one might expect from the name (hence it might need a change).

>So to implement an efficient tee, one would do something like:
>
>        /*
>         * Duplicate stdin to stdout
>         */
>        len = tee(STDIN_FILENO, STDOUT_FILENO, INT_MAX, SPLICE_F_NONBLOCK);

Creating new syscalls (and therefore library calls) always has potential of 
conflicting with user functions. Maybe new sys-lib-calls should show up as 
kernel_* under userspace.



Jan Engelhardt
-- 
