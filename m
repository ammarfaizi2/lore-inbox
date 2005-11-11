Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbVKKTJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVKKTJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVKKTJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:09:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46545 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751061AbVKKTJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:09:57 -0500
Subject: Re: [patch] mark text section read-only
From: Arjan van de Ven <arjan@infradead.org>
To: coywolf@sosdg.org
Cc: linux-kernel@vger.kernel.org, Josh Boyer <jdub@us.ibm.com>, ak@suse.de,
       akpm@osdl.org
In-Reply-To: <20051111190447.GA14481@everest.sosdg.org>
References: <20051107105624.GA6531@infradead.org>
	 <20051107105807.GB6531@infradead.org>
	 <1131372374.23658.1.camel@windu.rchland.ibm.com>
	 <1131373248.2858.17.camel@laptopd505.fenrus.org>
	 <2cd57c900511110139v221ed3f3m@mail.gmail.com>
	 <1131702428.2833.8.camel@laptopd505.fenrus.org>
	 <2cd57c900511111057n3a7741ddw@mail.gmail.com>
	 <20051111190447.GA14481@everest.sosdg.org>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 20:09:44 +0100
Message-Id: <1131736185.2833.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-11 at 14:04 -0500, Coywolf Qi Hunt wrote:
> On Sat, Nov 12, 2005 at 02:57:02AM +0800, Coywolf Qi Hunt wrote:
> > And we could also mark text section read-only and data/stack section
> > noexec if NX is supported. But I doubt the whole thing would really
> > help much. Kill the kernel thread? We can't. We only run into a panic.
> > Anyway I'd attach a quick patch to mark text section read only in the
> > next mail.
> > 
> > If it's ok, I'd add Kconfig support. Comments?
> 


change_page_attr() is only available on x86 and x86-64 so it needs to be
in arch/ somewhere...


