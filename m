Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263168AbUJ2JEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263168AbUJ2JEA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 05:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUJ2JD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 05:03:59 -0400
Received: from canuck.infradead.org ([205.233.218.70]:17156 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261390AbUJ2JDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 05:03:53 -0400
Subject: Re: [PATCH[ Export __PAGE_KERNEL_EXEC for modules (vmmon)
From: Arjan van de Ven <arjan@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041028221148.GE24972@vana.vc.cvut.cz>
References: <20041028221148.GE24972@vana.vc.cvut.cz>
Content-Type: text/plain
Message-Id: <1099040620.2641.11.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 29 Oct 2004 11:03:41 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 00:11 +0200, Petr Vandrovec wrote:
> Hello Ingo,
>   recently support for NX on i386 arrived to 2.6.x kernel, and I have
> some problems building code which uses vmap since then - PAGE_KERNEL_EXEC

why are you vmap'ing *executable* kernel memory?
That sounds very wrong.... very very wrong. The module loader needs it,
sure, but that's not modular. What on earth are you doing ????



