Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVCAXba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVCAXba (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 18:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVCAXba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 18:31:30 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:34502 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262118AbVCAXb3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 18:31:29 -0500
Subject: Re: cyrix_arr_init and centaur_mcr_init unused?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries.Brouwer@cwi.nl
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200502262150.j1QLoaH25198@apps.cwi.nl>
References: <200502262150.j1QLoaH25198@apps.cwi.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109719785.15795.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 01 Mar 2005 23:29:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-02-26 at 21:50, Andries.Brouwer@cwi.nl wrote:
> arch/i386/kernel/cpu/mtrr/cyrix.c has a routine cyrix_arr_init(), and
> arch/i386/kernel/cpu/mtrr/centaur.c has a routine centaur_mcr_init().
> At first sight it looks like these are unused.
> Do I overlook something?
> 
> (They occur as the .init fields of some struct, and I did not find any
> calls of ->init().)

Does look like a bug to me - and the centaur code definitely wants the
mcr init function to be called.


