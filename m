Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVCUD1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVCUD1N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 22:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVCUD1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 22:27:12 -0500
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:36767 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261519AbVCUD1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 22:27:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16958.16187.716183.994251@wombat.chubb.wattle.id.au>
Date: Mon, 21 Mar 2005 14:27:55 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: William Beebe <wbeebe@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
In-Reply-To: <e0716e9f05032019064c7b1cec@mail.gmail.com>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "William" == William Beebe <wbeebe@gmail.com> writes:

William> Sure enough, I created the following script and ran it as a
William> non-root user:

William> #!/bin/bash $0 & $0 &

There are two approaches to fixing this.
  1.  Rate limit fork().  Unfortunately some legitimate usges do a lot
      of forking, and you don't really want to slow them down.
  2.  Limit (per user) the number of processes allowed. This is what's
      currently done; and if you as administrator want to you can set
      RLIMIT_NPROC in /etc/security/limits.conf

On an almost-single-user system such as most desktops, there isn't much
point in setting this.  On shared systems, it can be useful.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
