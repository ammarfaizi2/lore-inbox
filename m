Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129237AbRBMRpu>; Tue, 13 Feb 2001 12:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRBMRpk>; Tue, 13 Feb 2001 12:45:40 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:49811 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129237AbRBMRpY>; Tue, 13 Feb 2001 12:45:24 -0500
Date: Tue, 13 Feb 2001 18:43:02 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: APIC problems
In-Reply-To: <Pine.LNX.4.30.0102121531400.22147-100000@ns-01.hislinuxbox.com>
Message-ID: <Pine.GSO.3.96.1010213183326.20214F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, David D.W. Downey wrote:

> I can see that the error codes are actually the values of ESR both before
> and after the apic_write() call. I see that the codes are the modulus'd
> value before and after the apic_write call. What I'm not understanding is
> how to translate that into a valid ID for determining what the exact error
> is. In this instance 08 doesn't appear to be a valid return. Or am I
> missing something here??

 "08" is "3: Receive accept error" -- all codes are explained in
smp_error_interrupt().  And yes, bits 0 - 3 indicate hardware problems
(due to marginal design, overheating, etc.), especially if seen in volume. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

