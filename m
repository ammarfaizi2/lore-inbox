Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbUC2H6q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 02:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbUC2H6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 02:58:45 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:62981 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262731AbUC2H6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 02:58:45 -0500
Subject: Re: 2.6.5-rc2-mm1 - swapoff dies with OOM, why?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: John Stoffel <stoffel@lucent.com>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <16487.35872.160526.477780@gargle.gargle.HOWL>
References: <16487.35872.160526.477780@gargle.gargle.HOWL>
Content-Type: text/plain
Message-Id: <1080547117.1137.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Mon, 29 Mar 2004 09:58:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 04:38, John Stoffel wrote:
> Hi all,
> 
> I've run into a strange situation here.  I was having *terrible*
> performance while doing a complile of the 2.6.5-rc2-mm2 kernel on my
> system (Debian completely bleeding edge, plus udev and hotplug) along
> with dealing with a USB problem where if I removed my Cuzer USB
> device, it would never get de-allocated properly and the system load
> would start to hang.

Are you using ext3? 2.6.5-rc2-mm1 has a memory leak that affects ext3
code. Thus, after some uptime of disk intensive work, nearly all memory
is wasted up. Please, upgrade to latest -mm tree (which ATM is
2.6.5-rc2-mm4).

