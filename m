Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270150AbTGNOrz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268476AbTGNOrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:47:55 -0400
Received: from ns.suse.de ([213.95.15.193]:10504 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S270150AbTGNOrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:47:43 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org,
       linux-m68k@lists.linux-m68k.org
Subject: Re: sizeof (siginfo_t) problem
References: <20030714084000.J15481@devserv.devel.redhat.com>
	<20030714135540.GB26002@mail.jlokier.co.uk>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Is something VIOLENT going to happen to a GARBAGE CAN?
Date: Mon, 14 Jul 2003 17:02:26 +0200
In-Reply-To: <20030714135540.GB26002@mail.jlokier.co.uk> (Jamie Lokier's
 message of "Mon, 14 Jul 2003 14:55:40 +0100")
Message-ID: <jewueldud9.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

|> Jakub Jelinek wrote:
|> > When siginfo_t was added, the intent obviously was that its size
|> > be 128 bytes on all arches.
|> > 
|> > The kernel unfortunately does this right on sparc64 and alpha from 64-bit
|> > arches only; ia64, s390x, ppc64 etc. got it wrong.
|> 
|> That's not the only siginfo_t problem:
|> 
|> 	- Take a look at the placement of the _uid32 field on m68k.
|> 	  It varies from sub-structure to sub-structure - yet it is
|> 	  always written to the same offset by the kernel.  Borken!

It should probably use the one from asm-generic as well.  I could not
find anything that actually uses that field.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
