Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVC2UNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVC2UNs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVC2UNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:13:39 -0500
Received: from gate.ebshome.net ([64.81.67.12]:6800 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S261363AbVC2UMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:12:10 -0500
Date: Tue, 29 Mar 2005 12:12:09 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <galak@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, shall@mvista.com,
       Jason McMullan <jason.mcmullan@timesys.com>
Subject: Re: [PATCH] ppc32: CPM2 PIC cleanup
Message-ID: <20050329201209.GB30850@gate.ebshome.net>
Mail-Followup-To: Kumar Gala <galak@freescale.com>,
	Andrew Morton <akpm@osdl.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	linux-kernel@vger.kernel.org, shall@mvista.com,
	Jason McMullan <jason.mcmullan@timesys.com>
References: <Pine.LNX.4.61.0503291039180.15390@blarg.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503291039180.15390@blarg.somerset.sps.mot.com>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 10:42:29AM -0600, Kumar Gala wrote:
> Andrew,
> 
> Cleaned up the CPM2 interrupt controller code:
> * Added the ability to offset the IRQs
> * Refactored common PIC init code out of platform files
> * Fixed IRQ offsets on MPC85xx so it can handle properly handled multiple 
> interrupt controllers (i8259, CPM2 PIC, and OpenPIC)
> 
> Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
> 

[snip]

Guys, while you are at it, could we renumber irq_to_siubit[] array in 
cpm2_pic.c so we can get rid of "1 << (31 - bit)" expressions and 
simply use "1 << bit"? I know, it's a minor thing, but you are 
cleaning this stuff anyway, why not make it super clean :).

--
Eugene
