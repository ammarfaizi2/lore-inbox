Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTJBWqo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 18:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263536AbTJBWqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 18:46:44 -0400
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:16800 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263535AbTJBWqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 18:46:43 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16252.43722.76247.635594@wombat.chubb.wattle.id.au>
Date: Fri, 3 Oct 2003 08:46:34 +1000
To: Hans-Georg Thien <1682-600@onlinehome.de>
Cc: linux-kernel@vger.kernel.org
Subject: getting timestamp of last interrupt?
In-Reply-To: <3F7C6319.4010407@onlinehome.de>
References: <3EB19625.6040904@onlinehome.de>
	<3EBAAC12.F4EA298D@hp.com>
	<3ED3CECA.9020706@onlinehome.de>
	<20030527231026.6deff7ed.subscript@free.fr>
	<3F7C6319.4010407@onlinehome.de>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Hans-Georg" == Hans-Georg Thien <1682-600@onlinehome.de> writes:

Hans-Georg> I am looking for a possibility to read out the last
Hans-Georg> timestamp when an interrupt has occured.

Hans-Georg> e.g.: the user presses a key on the keyboard. Where can I
Hans-Georg> read out the timestamp of this event?

Hans-Georg> To be more precise, I 'm looking for

Hans-Georg> ( )a function call ( ) a callback where I can register to
Hans-Georg> be notified when an event occurs ( ) a global accessible
Hans-Georg> variable ( ) a /proc entry

Hans-Georg> or something like that.

Hans-Georg> Any ideas ?

If you have the microstate accoounting patch applied, then the
timestamp of each  last IRQ is in the array msa_irq_entered[cpu][irq],
measured as an architecture-specific number.  Convert it to
nanoseconds since boot with MSA_TO_NSEC


Peter C
