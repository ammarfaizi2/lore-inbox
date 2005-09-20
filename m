Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbVITJiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbVITJiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 05:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVITJiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 05:38:54 -0400
Received: from aun.it.uu.se ([130.238.12.36]:64648 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S964948AbVITJix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 05:38:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17199.55458.181276.145487@alkaid.it.uu.se>
Date: Tue, 20 Sep 2005 11:38:42 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Gireesh Kumar" <gireesh.kumar@einfochips.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: regarding kernel compilation
In-Reply-To: <32854.192.168.9.246.1127197320.squirrel@192.168.9.246>
References: <32854.192.168.9.246.1127197320.squirrel@192.168.9.246>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gireesh Kumar writes:
 > Hi,
 > I'd like to compile 2.4.20-6 kernel while running in 2.6 kernel. I tried
 > to do so but there are redeclaration errors with /kernel/sched.c and
 > /include/linux/sched.h. One it is FASTCALL and the other it is not.
 > Can anyone help me to fix this?

Looks like you're trying to compile an ancient 2.4 kernel with gcc-3.4
or newer. That has zero chance of working.

Since that looks like a RH 2.4.20 kernel, you should probably use
gcc-3.2.3 to compile it. Alternatively you can use gcc-3.4 with the
current 2.4.31 kernel.

Some 2.6-based distributions do have problems running 2.4 kernels:
FC3 needs some minor tweaks (replace udev and module-init-tools with
dev and modutils from FC2) but FC4 is a lost cause due to NPTL.
