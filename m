Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVBXW02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVBXW02 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 17:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbVBXW01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 17:26:27 -0500
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:40898 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262508AbVBXW0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 17:26:21 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16926.21614.267728.100131@wombat.chubb.wattle.id.au>
Date: Fri, 25 Feb 2005 09:25:50 +1100
To: "Chad N. Tindel" <chad@tindel.net>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
In-Reply-To: <20050224173356.GA11593@calma.pair.com>
References: <20050223230639.GA33795@calma.pair.com>
	<20050223183634.31869fa6.akpm@osdl.org>
	<20050224052630.GA99960@calma.pair.com>
	<421DD5CC.5060106@aitel.hist.no>
	<20050224173356.GA11593@calma.pair.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Chad" == Chad N Tindel <chad@tindel.net> writes:

Chad> I would make the following assertion for any kernel:

Chad> No single userspace thread of execution running on an SMP system
Chad> should be able to hose a box by going CPU-bound, bug in the
Chad> software or no bug.  Any kernel should be able to handle this
Chad> case and shift general work over to other processors.

In many Unices, crucial kernel threads run at realtime priority with a
static priority higher than is accessible to user code.

That being said, however, you've got to be a privileged user to set
real time very high priority on a thread, and if you do, you'd better
know what you're doing.  Any SCHED_FIFO thread should run for a time,
then sleep for a time, or it *will* DOS everything else on the
processor.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
