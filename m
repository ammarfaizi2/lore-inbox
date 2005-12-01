Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVLAR5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVLAR5u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVLAR5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:57:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6578 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932381AbVLAR5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:57:49 -0500
Date: Thu, 1 Dec 2005 12:57:32 -0500
From: Dave Jones <davej@redhat.com>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix bytecount result from printk()
Message-ID: <20051201175732.GD19433@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Mark Lord <lkml@rtr.ca>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <438F1D05.5020004@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438F1D05.5020004@rtr.ca>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 10:55:49AM -0500, Mark Lord wrote:
 > printk() returns a bytecount, which nothing actually appears to use.

We do check it in a few places.

arch/x86_64/kernel/traps.c:                             i += printk(" "); \
arch/x86_64/kernel/traps.c:                     i += printk(" <%s> ", id);
arch/x86_64/kernel/traps.c:                     i += printk(" <EOE> ");
arch/x86_64/kernel/traps.c:                             i += printk(" <IRQ> ");
arch/x86_64/kernel/traps.c:                             i += printk(" <EOI> ");
drivers/char/mem.c:             ret = printk("%s", tmp);

		Dave

