Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVCQW22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVCQW22 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVCQW2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:28:21 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:39142 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261303AbVCQW1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:27:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16954.1107.911531.142306@wombat.chubb.wattle.id.au>
Date: Fri, 18 Mar 2005 09:27:31 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: vm_dirty_ratio seems a bit large.
In-Reply-To: <20050317133148.1122e9c4.akpm@osdl.org>
References: <20050317205213.GC17353@lnx-holt.americas.sgi.com>
	<20050317133148.1122e9c4.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> Robin Holt <holt@sgi.com> wrote:

>>  One other issue we have is the vm_dirty_ratio and background_ratio
>> adjustments are a little coarse with these memory sizes.  Since our
>> minimum adjustment is 1%, we are adjusting by 40GB on the largest
>> configuration from above.  The hardware we are shipping today is
>> capable of going to far greater amounts of memory, but we don't
>> have customers demanding that yet.  I would like to plan ahead for
>> that and change vm_dirty_ratio from a straight percent into a
>> millipercent (thousandth of a percent).  Would that type of change
>> be acceptable?

Andrew> Oh drat.  I think such a change would require a new set of
Andrew> /proc entries.  

No, you could just extend them to understand fixed point.  Keep
printing integers as integers, print non-integers with one (or two:
will we ever need 0.01% increments?) decimal places.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
