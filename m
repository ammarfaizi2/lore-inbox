Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTLECjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 21:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbTLECjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 21:39:54 -0500
Received: from mail019.syd.optusnet.com.au ([211.29.132.73]:22165 "EHLO
	mail019.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263796AbTLECjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 21:39:53 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16335.61394.767472.292269@wombat.chubb.wattle.id.au>
Date: Fri, 5 Dec 2003 13:39:14 +1100
To: Philippe Troin <phil@fifi.org>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, rob@landley.net,
       linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
In-Reply-To: <873cc0nkgf.fsf@ceramic.fifi.org>
References: <200312041432.23907.rob@landley.net>
	<16335.47878.628726.26978@wombat.chubb.wattle.id.au>
	<873cc0nkgf.fsf@ceramic.fifi.org>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Philippe" == Philippe Troin <phil@fifi.org> writes:

Philippe> Peter Chubb <peter@chubb.wattle.id.au> writes:
>> >>>>> "Rob" == Rob Landley <rob@landley.net> writes:
>> 
Rob> You can make a file with a hole by seeking past it and never
Rob> writing to that bit, but is there any way to punch a hole in a
Rob> file after the fact?  (I mean other with lseek and write.  Having
Rob> a sparse file as the result....)
>> SVr4 has fcntl(fd, F_FREESP, flock) that frees the space covered by
>> the struct flock in the file.  Linux doesn't have this, at least in
>> the baseline kernels.

Philippe> However most SVr4 (at least Solaris and HP-UX) only
Philippe> implement FREESP when the freed space is at the file's
Philippe> tail. In other words, FREESP can only be used to implement
Philippe> ftruncate().

The original SVr4 worked in the middle of files too.

