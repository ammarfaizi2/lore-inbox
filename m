Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288452AbSA0Tgw>; Sun, 27 Jan 2002 14:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288460AbSA0Tgc>; Sun, 27 Jan 2002 14:36:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29193 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288452AbSA0Tga>; Sun, 27 Jan 2002 14:36:30 -0500
Subject: Re: Daemonize() should re-parent its caller
To: stern@rowland.org (Alan Stern)
Date: Sun, 27 Jan 2002 19:48:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.33L2.0201231050440.687-100000@ida.rowland.org> from "Alan Stern" at Jan 23, 2002 10:54:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16UvIF-0002KG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But a more elegant and economical solution is to have the daemonize()
> routine automatically re-parent its caller to be a child of init
> (assuming the caller's parent isn't init already).  At the same time,
> the caller's exit_signal should be set to SIGCHLD.  This would
> definitely solve the problem, and it is unlikely to introduce any
> incompatibilities with existing code.

We have a seperate reparent_to_init() function in 2.4 to do this. That was
kept seperately mostly to avoid introducing mysterious changes of behaviour
in daemonize() calls during 2.4

For 2.5 I agree, the reparent_to_init belongs in daemonize()
