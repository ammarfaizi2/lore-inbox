Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291036AbSBSKVO>; Tue, 19 Feb 2002 05:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291038AbSBSKVE>; Tue, 19 Feb 2002 05:21:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61196 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291036AbSBSKUs>; Tue, 19 Feb 2002 05:20:48 -0500
Subject: Re: OOM killer
To: pmartinez@heraldo.es (Paco Martinez)
Date: Tue, 19 Feb 2002 10:34:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <032801c1b92c$d0991f00$ef01a8c0@PCZ014> from "Paco Martinez" at Feb 19, 2002 11:02:50 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16d7bR-00005Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you know any newer kernel that solves problem about "OOM Killer" ??
> Thank you !!!!

I've had no problem with bogus out of memory cases in either 2.4.18-rc, or
the 2.4.18-ac tree (which adds the rmap vm improvements). I'm also working
at the moment on adding support for strict memory overcommit handling so
that you can opt to be sure OOM will not happen, and that a program will
always get out of memory returns from a syscall (or if you are really
really unlucky a kill from a stackfault on an app that doesnt take the
right care)
