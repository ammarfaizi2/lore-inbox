Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbUL2N6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbUL2N6C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 08:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbUL2N6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 08:58:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39403 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261349AbUL2N57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 08:57:59 -0500
Date: Wed, 29 Dec 2004 08:57:11 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: PATCH: 2.6.10 - Misrouted IRQ recovery for review
In-Reply-To: <1104249508.22366.101.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0412290852590.21290@devserv.devel.redhat.com>
References: <1104249508.22366.101.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Dec 2004, Alan Cox wrote:

> Ported to the new kernel/irq code.

looks good to me. I think it might make sense to default-enable it for
testing and try it in -mm, to see how acceptable it would be for
mainstream (and for non-x86 architectures)? In theory this should not
break systems that have a perfect IRQ routing setup, and it could make a
crutial difference for systems that have IRQ routing problems. The current
opt-in flag will not give enough testing i believe.

	Ingo
