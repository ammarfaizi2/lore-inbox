Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266769AbUG1C2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266769AbUG1C2F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 22:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266770AbUG1C2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 22:28:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38874 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266769AbUG1C2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 22:28:02 -0400
Date: Tue, 27 Jul 2004 19:24:54 -0700
From: "David S. Miller" <davem@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: kaos@sgi.com, akpm@osdl.org, zwane@linuxpower.ca, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] Allow x86_64 to reenable interrupts on contention
Message-Id: <20040727192454.787c6b62.davem@redhat.com>
In-Reply-To: <20040728022131.GL2334@holomorphy.com>
References: <20040728004030.GK2334@holomorphy.com>
	<2479.1090979285@kao2.melbourne.sgi.com>
	<20040728022131.GL2334@holomorphy.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 19:21:31 -0700
William Lee Irwin III <wli@holomorphy.com> wrote:

> and may also have issues with
> architectures (e.g. sparc/sparc64) which need the interrupt disablement
> in e.g. spin_lock_irqsave() to be done in the same call frame as the
> spin_unlock_irqrestore() etc.

This only was a problem on sparc, and it no longer exists at all
in 2.6.x kernels.  It was too much of a pain to keep teaching
people that violated this, and it resulted in some contorted
code as well.

So don't worry about this at all in 2.6.x and later.
