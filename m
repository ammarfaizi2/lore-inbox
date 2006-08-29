Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbWH2QZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWH2QZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWH2QZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:25:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52622 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965063AbWH2QZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:25:29 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060829162055.GA31159@linux-mips.org> 
References: <20060829162055.GA31159@linux-mips.org>  <44F395DE.10804@yahoo.com.au> <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0608290855510.18031@schroedinger.engr.sgi.com> 
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Christoph Lameter <clameter@sgi.com>, David Howells <dhowells@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 29 Aug 2006 17:25:02 +0100
Message-ID: <5878.1156868702@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle <ralf@linux-mips.org> wrote:

> > Which arches do not support cmpxchg?
> 
> MIPS, Alpha - probably any pure RISC load/store architecture.

Some of these have LL/SC or equivalent instead, but ARM5 and before, FRV, M68K
before 68020 to name but a few.

And anything that implements CMPXCHG with spinlocks is a really bad candidate
for CMPXCHG-based rwsems.

David
