Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277258AbRK0Lw5>; Tue, 27 Nov 2001 06:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277514AbRK0Lwr>; Tue, 27 Nov 2001 06:52:47 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:51332 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S277258AbRK0Lwl>; Tue, 27 Nov 2001 06:52:41 -0500
Date: Tue, 27 Nov 2001 12:50:09 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel@vger.kernel.org, VLAN Mailing List <vlan@Scry.WANfear.com>
Subject: Re: [patch] 2.4.16: 802.1Q VLAN non-modular
In-Reply-To: <3C030A73.8080506@candelatech.com>
Message-ID: <Pine.GSO.3.96.1011127124410.440A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Ben Greear wrote:

> By the way, I just successfully compiled 2.4.16 (including VLAN
> builtin) with no problems.  It looks like Maciej is compiling
> MIPS, so it may be a bug particular to that platform??

 This might be because I'm using current binutils (i.e. 2.11.92 from the
CVS). I believe there was a bug in older versions where relocations
against symbols from discarded sections were still resolved, to a useless
value (zero, I think).  Thus you may be lucky to get the kernel built, but
if the symbol ever gets referenced (the gets function called), bad things
will happen.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

