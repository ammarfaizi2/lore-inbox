Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290720AbSBFSQD>; Wed, 6 Feb 2002 13:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290722AbSBFSPl>; Wed, 6 Feb 2002 13:15:41 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:44498 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S290720AbSBFSPe>; Wed, 6 Feb 2002 13:15:34 -0500
Date: Wed, 6 Feb 2002 19:11:18 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jakub Jelinek <jakub@redhat.com>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel: ldt allocation failed
In-Reply-To: <20020206101231.X21624@devserv.devel.redhat.com>
Message-ID: <Pine.GSO.3.96.1020206190051.11725I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, Jakub Jelinek wrote:

> Most sane architectures reserve a thread pointer register (%g6 resp. %g7 on
> sparc, tp on ia64, ppc will use %r2, alpha uses a fast pall call as thread
> "register", s390 uses user access register 0 (and s390x uar 0 and 1), etc.).
> On register starved ia32 there aren't too many spare registers, so %gs is
> used instead.

 Actually really sane architectures, such as MIPS, have no unused
registers floating around just in case someone needs one in the next ten
years or so.  They require an ABI change which can only be justified if
the benefit is large.  So far I failed to see the benefit, but hopefully
it's only a fault of mine.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

