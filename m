Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267321AbTBEMlC>; Wed, 5 Feb 2003 07:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbTBEMlC>; Wed, 5 Feb 2003 07:41:02 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:7519 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267321AbTBEMlC>; Wed, 5 Feb 2003 07:41:02 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200302051250.h15CoYL08406@devserv.devel.redhat.com>
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 5 Feb 2003 07:50:34 -0500 (EST)
Cc: skraw@ithnet.com (Stephan von Krawczynski), alan@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1044447738.685.113.camel@zion.wanadoo.fr> from "Benjamin Herrenschmidt" at Feb 05, 2003 01:22:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > dual-mb the kernel is already compiled for SMP. It is started with "nosmp"
> > option though. I wanted to mention this not knowing if it is important for the
> > codepath.
> 
> Shouldn be an issue. I suppose you don't use fancy stuff like preempt or
> IDE taskfile IO, right ?

IDE taskfile I/O is disabled. Pre-empt and 2.4 IDE don't work together at
all yet, and probably never will (see the /proc code for why its basically
unfixable in 2.4)
