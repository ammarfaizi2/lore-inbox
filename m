Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWJCPBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWJCPBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWJCPBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:01:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13201 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964809AbWJCPBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:01:47 -0400
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
From: Arjan van de Ven <arjan@infradead.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Valdis.Kletnieks@vt.edu
In-Reply-To: <451E3C0C.10105@aknet.ru>
References: <45150CD7.4010708@aknet.ru>
	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>
	 <451555CB.5010006@aknet.ru>
	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>
	 <1159037913.24572.62.camel@localhost.localdomain>
	 <45162BE5.2020100@aknet.ru>
	 <1159106032.11049.12.camel@localhost.localdomain>
	 <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com>
	 <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>
	 <45198395.4050008@aknet.ru>
	 <1159396436.3086.51.camel@laptopd505.fenrus.org>  <451E3C0C.10105@aknet.ru>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 03 Oct 2006 17:01:22 +0200
Message-Id: <1159887682.2891.537.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-30 at 13:42 +0400, Stas Sergeev wrote:
> Hello.
> 
> Arjan van de Ven wrote:
> >>/ wants to be able to mark more partitions as noexec,/
> > .... and then execute from them!
> > that's what is bothering me most about all of this.
> Do you mean "execute with ld.so", or "execute with PROT_EXEC mmap"?

no what bothers me that on the one hand you want no execute from the
partition, and AT THE SAME TIME want stuff to execute from there (being
libraries or binaries, same thing to me). That duality feels strange to
me, I could understand if you wanted noexec to be MORE strict; I fail to
understand why you want it LESS strict!
What breaks?


