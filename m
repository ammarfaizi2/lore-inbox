Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbUJXRa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbUJXRa7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 13:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbUJXRa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 13:30:59 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:42887 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261560AbUJXRaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 13:30:55 -0400
Subject: Re: getting rid of inter_module_xx
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041023094413.GA30137@infradead.org>
References: <9e473391041022100835da7baf@mail.gmail.com>
	 <20041023094413.GA30137@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098635275.24241.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 24 Oct 2004 17:27:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-10-23 at 10:44, Christoph Hellwig wrote:
> not at all.  Everything else in the kernel is compile-time depencies.
> Just make the agp backend module mandatory if CONFIG_AGP is set, you'll
> lose tons of complexity at a minimum amount of used memory, and as an
> added benefit look like the rest of the kernel.

Thats completely stupid

CONFIG_AGP enables the building of AGP modules, it does not disable the
ability to run that kernel on non AGP setups, or to use non AGP video
cards.

The relationship is dynamic and you'd need to fix the various drivers
that support both PCI and AGP mode by compiling them twice so you can
load them with or without agp support.

Yuck yuck yuck. It would instead be much saner to fix the module loader
to support weak symbols.

Alan
