Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132825AbREHQQH>; Tue, 8 May 2001 12:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132850AbREHQP6>; Tue, 8 May 2001 12:15:58 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:13513 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132825AbREHQPq>; Tue, 8 May 2001 12:15:46 -0400
Date: Tue, 8 May 2001 18:01:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Edward Spidre <beamz_owl@yahoo.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Possible PCI subsystem bug in 2.4
In-Reply-To: <m1u230mjxo.fsf@frodo.biederman.org>
Message-ID: <Pine.GSO.3.96.1010508174820.26399A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 May 2001, Eric W. Biederman wrote:

> The example that sticks out in my head is we rely on the MP table to
> tell us if the local apic is in pic_mode or in virtual wire mode.
> When all we really have to do is ask it.

 You can't.  IMCR is write-only and may involve chipset-specific
side-effects.  Then even if IMCR exists, a system's firmware might have
chosen the virtual wire mode for whatever reason (e.g. broken hardware). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

