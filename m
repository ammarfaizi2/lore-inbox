Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268397AbUHYGNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268397AbUHYGNr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 02:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268482AbUHYGNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 02:13:47 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:59406 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268397AbUHYGNp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 02:13:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Tom Vier <tmv@comcast.net>, Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Possible dcache BUG
Date: Wed, 25 Aug 2004 09:13:23 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408232308.41244.gene.heskett@verizon.net> <20040825014937.GC15901@zero>
In-Reply-To: <20040825014937.GC15901@zero>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200408250913.23840.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 August 2004 04:49, Tom Vier wrote:
> On Mon, Aug 23, 2004 at 11:08:41PM -0400, Gene Heskett wrote:
> > >are you translating virt->phys?
> >
> > No, this is straight out of the memburn output (after I'd fixed the
>
> that's weird that you're finding that pattern in virtual addresses. i
> wouldn't expect that. even if you're booting to single user, certain
> variables might change during boot and cause different physical pages to be
> mapped. maybe single user is more deterministic than i think, though.

On x86, pages are aligned at 4k. Lower 12 bits of virtual address
match lower 12 bits of corresponding real address.

So, yes, if you hit bad RAM cell, you see random virtual address, but
three last digits of it (in hex) must be the same.
--
vda
