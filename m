Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbTLZTol (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 14:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265216AbTLZTol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 14:44:41 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:60812 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265210AbTLZTok
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 14:44:40 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 26 Dec 2003 11:44:35 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Arjan van de Ven <arjanv@redhat.com>
cc: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <riel@surriel.com>
Subject: Re: Page aging broken in 2.6
In-Reply-To: <1072430500.5222.2.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.44.0312261140030.2022-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Dec 2003, Arjan van de Ven wrote:

> 
> > > And we never flush the TLB entry. 
> > > 
> > > I don't know if x86 (or other archs really using page tables) will
> > > actually set the referenced bit again in the PTE if it's already set
> > > in the TLB, if not, then x86 needs a flush too.
> > 
> > x86 needs a flush_tlb_page(), yes.
> 
> it does? Are you 100% sure ?

According to the Intel doc #24319202, section 3.7, it is OS responsibility 
to invalidate the TLB entry.



- Davide


