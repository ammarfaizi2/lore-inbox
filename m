Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBUR7O>; Wed, 21 Feb 2001 12:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129144AbRBUR7E>; Wed, 21 Feb 2001 12:59:04 -0500
Received: from host217-32-138-113.hg.mdip.bt.net ([217.32.138.113]:4872 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129051AbRBUR6r>;
	Wed, 21 Feb 2001 12:58:47 -0500
Date: Wed, 21 Feb 2001 18:01:46 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Burton Windle <burton@fint.org>, linux-kernel@vger.kernel.org
Subject: Re: Detecting SMP
In-Reply-To: <Pine.LNX.3.96.1010221115214.13788T-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0102211758290.2050-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001, Jeff Garzik wrote:

> On Wed, 21 Feb 2001, Tigran Aivazian wrote:
> > yes, just run the famous mptable program. If the machine is SMP then it
> > will have a valid Intel MP 1.4 configuration tables so the program will
> > show meaningful output.
> 
> Does that allow you to detect multiple processors... or just an SMP board?
> 

the answer is in section 4.1 of the Intel MP 1.4 spec:

   "An MP-compliant system must implement the MP floating pointer
    structure, ..."

So, one would normally expect this to mean an SMP board rather than
multiple processors, _HOWEVER_, I can imagine a very clever MP-aware BIOS
implementation which detects that there are many processors and prepares
MP floating config table and does _not_ prepare it otherwise. So, it all
depends on the BIOS implementation.

Actually, I never tried unplugging all-1 processors from my SMP machines
and seeing what sort of MP table is left...

Regards,
Tigran

