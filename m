Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbTLDWyc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbTLDWyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:54:32 -0500
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:56274 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263666AbTLDWyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:54:31 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16335.47878.628726.26978@wombat.chubb.wattle.id.au>
Date: Fri, 5 Dec 2003 09:53:58 +1100
To: rob@landley.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
In-Reply-To: <200312041432.23907.rob@landley.net>
References: <200312041432.23907.rob@landley.net>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Rob" == Rob Landley <rob@landley.net> writes:

Rob> You can make a file with a hole by seeking past it and never
Rob> writing to that bit, but is there any way to punch a hole in a
Rob> file after the fact?  (I mean other with lseek and write.  Having
Rob> a sparse file as the result....)


SVr4 has fcntl(fd, F_FREESP, flock) that frees the space covered by
the struct flock in the file.  Linux doesn't have this, at least in
the baseline kernels.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
