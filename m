Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbRBTNwA>; Tue, 20 Feb 2001 08:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129402AbRBTNvu>; Tue, 20 Feb 2001 08:51:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49416 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129227AbRBTNve>; Tue, 20 Feb 2001 08:51:34 -0500
Subject: Re: [PATCH] new setprocuid syscall
To: peter@cadcamlab.org (Peter Samuelson)
Date: Tue, 20 Feb 2001 13:52:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <14994.27891.171934.348706@wire.cadcamlab.org> from "Peter Samuelson" at Feb 20, 2001 07:11:15 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VDD2-0006ha-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fair enough but could you explain the potential problems?  And how is
> it different from sys_setpriority?

Suppose you change a tasks uid in parallel with the set of conditionals
in setuid - just as one example. Or you change uid _during_ a quota operation.
Or during sys5 ipc ops.

All of these and more make assumptions. The idea of locking uid changes with
semaphores would produce some truely horrible performance impacts

