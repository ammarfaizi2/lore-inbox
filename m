Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276888AbRJHQAQ>; Mon, 8 Oct 2001 12:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272818AbRJHQAG>; Mon, 8 Oct 2001 12:00:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22798 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276888AbRJHQAB>; Mon, 8 Oct 2001 12:00:01 -0400
Subject: Re: [PATCH] Provide system call to get task id
To: dmccr@us.ibm.com (Dave McCracken)
Date: Mon, 8 Oct 2001 17:05:48 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <71000000.1002555975@baldur> from "Dave McCracken" at Oct 08, 2001 10:46:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qcua-00010T-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch provides a new system call gettid() (get task id), which
> returns the true pid of the task.  This is needed in some multi-threaded
> apps and libraries.

Really the fix is to back out the stupid getpid hack. The thread group
is known by user space and can be managed by user space
