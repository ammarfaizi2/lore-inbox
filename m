Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbULUOqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbULUOqu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 09:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbULUOqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 09:46:49 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:52200 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261767AbULUOqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 09:46:31 -0500
Date: Tue, 21 Dec 2004 15:46:24 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arun C Murthy <acmurthy@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: at_fork & at_exit
In-Reply-To: <41C835C7.2010203@gmail.com>
Message-ID: <Pine.LNX.4.61.0412211544430.22006@yvahk01.tjqt.qr>
References: <41C835C7.2010203@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> Im looking for linux equivalent of the FreeBSD calls:
>
> 1. at_fork
>
> typedef void
> (*forklist_fn)(struct proc *, struct proc *, int);
>
>    int at_fork(forklist_fn func);

I do not see such a hook in the kernel source tree, so adding your own seems 
to only way.

The places are in kernel/fork.c:copy_process() and 
kernel/exit.c:__unhash_process



Jan Engelhardt
-- 
ENOSPC
