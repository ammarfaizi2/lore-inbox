Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264916AbUELBqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUELBqI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 21:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbUELBoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 21:44:01 -0400
Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:15149
	"EHLO 2003SERVER.sbs2003.local") by vger.kernel.org with ESMTP
	id S264916AbUELBmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 21:42:37 -0400
thread-index: AcQ3wtdNL6ipXcOtRwGB4qRGA9IqQA==
X-Sieve: Server Sieve 2.2
Date: Wed, 12 May 2004 02:45:44 +0100
From: "Matt Porter" <mporter@kernel.crashing.org>
To: <Administrator@vger.kernel.org>
Cc: "Matt Porter" <mporter@kernel.crashing.org>, <akpm@osdl.org>,
       <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@lists.linuxppc.org>
Message-ID: <000201c437c2$d75017b0$d100000a@sbs2003.local>
Subject: Re: [PATCH 1/2] PPC32: New OCP core support
Content-Transfer-Encoding: 7bit
References: <20040511170150.A4743@home.com> <200405120039.i4C0dHs0010426@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
X-Mailer: Microsoft CDO for Exchange 2000
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200405120039.i4C0dHs0010426@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Tue, May 11, 2004 at 08:39:17PM -0400
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
Content-Class: urn:content-classes:message
Envelope-to: paul@sumlocktest.fsnet.co.uk
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.132
X-me-spamlevel: not-spam
X-me-spamrating: 7.721957
X-OriginalArrivalTime: 12 May 2004 01:45:44.0906 (UTC) FILETIME=[D754D2A0:01C437C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, May 11, 2004 at 08:39:17PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 11 May 2004 17:01:50 PDT, Matt Porter said:
> > New OCP infrastructure ported from 2.4 along with several
> > enhancements. Please apply.
>
> Big honking patch.  Wholesale removal of old code. Wholesale addition of new code.

Yep.

> And this is the closest to a hint of what an OCP in the old code:

<snip>

> I'm *guessing* that this is some all-in-one integrated north/south/PCI/east bridge
> with an APIC or similar and some I/O controllers....  Or maybe it's a board-level
> designator like 'ebony' seems to be.. or something..
>
> It's a UART... or a Bus-level board.. or both.. ;)

Actually, OCP stands for On-Chip Peripheral and is the basic system
we've used in ppc32 for some time now to abstract dumb peripherals
behind a standard API.  BenH did yet another rewrite of OCP in 2.4
sometime ago and I picked up that work to port to 2.6 and the new
device model.  It is a software abstraction, and easily allows us to
plug in SoC descriptors when new chips come out and use standard
apis to modify device entries on a per-board basis during
"setup_arch() time". It used to be PPC4xx-specific, but now is being
used by PPC85xx, MV64xxx, and MPC52xx based PPC systems. "Now", meaning
that the respective developers for those parts are using the OCP
working tree to base their 2.6 ports off of.

> (Actually, other than the apparent lack of any comment that says what an OCP
> in fact is, I didn't see any really big style problems while scrolling through it..)

Ahh, good.

-Matt

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


