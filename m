Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbUCYWEn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbUCYWEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:04:42 -0500
Received: from gate.in-addr.de ([212.8.193.158]:3497 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S263627AbUCYWEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:04:38 -0500
Date: Thu, 25 Mar 2004 23:04:34 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>, Kevin Corry <kevcorry@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-raid@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
Message-ID: <20040325220434.GW15264@marowsky-bree.de>
References: <760890000.1079727553@aslan.btc.adaptec.com> <16480.61927.863086.637055@notabene.cse.unsw.edu.au> <40624235.30108@pobox.com> <200403251200.35199.kevcorry@us.ibm.com> <40632804.1020101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40632804.1020101@pobox.com>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-03-25T13:42:12,
   Jeff Garzik <jgarzik@pobox.com> said:

> >and -5). And we've talked for a long time about wanting to port RAID-1 and 
> >RAID-5 (and now RAID-6) to Device-Mapper targets, but we haven't started 
> >on any such work, or even had any significant discussions about *how* to 
> >do it. I can't 
> let's have that discussion :)

Nice 2.7 material, and parts I've always wanted to work on. (Including
making the entire partition scanning user-space on top of DM too.)

KS material?

> My take on things...  the configuration of RAID arrays got a lot more 
> complex with DDF and "host RAID" in general.

And then add all the other stuff, like scenarios where half of your RAID
is "somewhere" on the network via nbd, iSCSI or whatever and all the
other possible stackings... Definetely user-space material, and partly
because it /needs/ to have the input from the volume managers to do the
sane things.

The point about this implying that the superblock parsing/updating logic
needs to be duplicated between userspace and kernel land is valid too
though, and I'm keen on resolving this in a way which doesn't suck...


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

