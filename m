Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263137AbVGaASZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbVGaASZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 20:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbVGaARe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 20:17:34 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:29387 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263128AbVGaAPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 20:15:20 -0400
Subject: Re: Simple question re: oops
From: Lee Revell <rlrevell@joe-job.com>
To: Alexander Nyberg <alexn@telia.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050731001101.GA6762@localhost.localdomain>
References: <1122767292.4464.1.camel@mindpipe>
	 <20050731001101.GA6762@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 30 Jul 2005 20:15:15 -0400
Message-Id: <1122768916.4464.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-31 at 02:11 +0200, Alexander Nyberg wrote:
> On Sat, Jul 30, 2005 at 07:48:11PM -0400 Lee Revell wrote:
> 
> > I have a machine here that oopses reliably when I start X, but the
> > interesting stuff scrolls away too fast, and a bunch more Oopses get
> > printed ending with "Aieee, killing interrupt handler".
> > 
> > How do I get the output to stop after the first Oops?
> > 
> 
> set /proc/sys/kernel/panic_on_oops to 1
> 
> What version of the kernel is that? It shouldn't do recursive oopses
> (of the same task) any more.
> 

2.6.10 (whatever comes with Ubuntu Hoary).  It's a demo install for a
client on cobbled together hardware.  First I suspected the bleeding
edge GeForce video card, then we swapped it which didn't help.  Now I
suspect the hard drive (or a kernel bug).

And I was wrong, it wasn't more Oopses, it was "scheduling while atomic"
messages that forced the interesting stuff offscreen.

Lee

