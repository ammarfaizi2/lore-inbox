Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWAYGzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWAYGzm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 01:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWAYGzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 01:55:42 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:41407
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750732AbWAYGzl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 01:55:41 -0500
Subject: Re: [PATCH 3/7] [hrtimers] Fix oldvalue return in setitimer
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Orion Poplawski <orion@cora.nwra.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dr67pj$uom$1@sea.gmane.org>
References: <20060120021336.134802000@tglx.tec.linutronix.de>
	 <20060120021342.498532000@tglx.tec.linutronix.de>
	 <dr67pj$uom$1@sea.gmane.org>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 07:56:37 +0100
Message-Id: <1138172197.26132.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-24 at 14:56 -0700, Orion Poplawski wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Thomas Gleixner wrote:
> > This resolves bugzilla bug#5617. The oldvalue of the
> > timer was read after the timer was cancelled, so the
> > remaining time was always zero.
> > 
> 
> I'm seeing this problem on recent Fedore development kernels.
> Interestingly, it causes the IDL 7 minute timed demo to exit immediately
> upon trying to plot since it resets the timer and expects the old value
> to be returned.

Thats the same problem.

	tglx


