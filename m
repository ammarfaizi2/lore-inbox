Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUCYXnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 18:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263684AbUCYXnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:43:32 -0500
Received: from gate.in-addr.de ([212.8.193.158]:35756 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S263664AbUCYXn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:43:29 -0500
Date: Fri, 26 Mar 2004 00:44:52 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>, Kevin Corry <kevcorry@us.ibm.com>,
       linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-raid@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
Message-ID: <20040325234452.GC15264@marowsky-bree.de>
References: <760890000.1079727553@aslan.btc.adaptec.com> <16480.61927.863086.637055@notabene.cse.unsw.edu.au> <40624235.30108@pobox.com> <200403251200.35199.kevcorry@us.ibm.com> <1019470000.1080255540@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1019470000.1080255540@aslan.btc.adaptec.com>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-03-25T15:59:00,
   "Justin T. Gibbs" <gibbs@scsiguy.com> said:

> The fact of the matter is that neither EMD nor DM provide a generic
> morphing capability.  If this is desirable, we can discuss how it could
> be achieved, but my initial belief is that attempting any type of
> complicated morphing from userland would be slow, prone to deadlocks,
> and thus difficult to achieve in a fashion that guaranteed no loss of
> data in the face of unexpected system restarts.

Uhm. DM sort of does (at least where the morphing amounts to resyncing a
part of the stripe, ie adding a new mirror, RAID1->4, RAID5->6 etc).
Freeze, load new mapping, continue.

I agree that more complex morphings (RAID1->RAID5 or vice-versa in
particular) are more difficult to get right, but are not that often
needed online - or if they are, typically such scenarios will have
enough temporary storage to create the new target, RAID1 over,
disconnect the old part and free it, which will work just fine with DM.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

