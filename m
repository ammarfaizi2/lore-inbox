Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVAXXxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVAXXxs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVAXXwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:52:42 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:31144 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261737AbVAXXuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:50:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16885.35235.411994.645619@wombat.chubb.wattle.id.au>
Date: Tue, 25 Jan 2005 10:49:55 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Support for Large Block Devices
In-Reply-To: <246561836.20050123181145@dns.toxicfilms.tv>
References: <246561836.20050123181145@dns.toxicfilms.tv>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Maciej" == Maciej Soltysiak <solt2@dns.toxicfilms.tv> writes:

Maciej> Hi, I was wondering... Why is "Support for Large Block
Maciej> Devices" still an option?

Maciej> Shouldn't it be compiled in always?  Or maybe there are some
Maciej> cons like incompatibility or something?

It's not compiled in always on 32-bit platforms, because
     1.  Most people don't have more than 2TB in a single block device
     2.  64-bit sizes mean increased size of various structures (i.e.,
         less cache-friendly), and slightly slower operations.

On 64-bit platforms it *is* always enabled.
-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
