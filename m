Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267556AbUIBFqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267556AbUIBFqQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 01:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267523AbUIBFpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 01:45:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:24758 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267520AbUIBFpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 01:45:22 -0400
Date: Wed, 1 Sep 2004 22:43:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jagdmann@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: prevent hdd spin-down at system halt
Message-Id: <20040901224326.56972733.akpm@osdl.org>
In-Reply-To: <1094035338.2399.33.camel@localhost.localdomain>
References: <5d0f609904083107571d78a41@mail.gmail.com>
	<5d0f6099040901030137a7f641@mail.gmail.com>
	<1094035338.2399.33.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Mer, 2004-09-01 at 11:01, Dirk Jagdmann wrote:
> > is it possible to disable the spin-down (or powerdown) of hard disks
> > when halting the system, via the kernel cmd-line or some
> > configurations in /proc?
> 
> If someone provides the shutdown infrastructure to determine the
> difference between shutdown/poweroff/return-to-firmware its easy. IDE
> already has an ifdef to handle this on Alpha SRM because the higher
> levels don't provide the ideal information.
> 

People are using the system_state global for this.  I guess this will suit
until it breaks, and we end up doing something else.

See sys_reboot().
