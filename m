Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTKNKQp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 05:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbTKNKQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 05:16:45 -0500
Received: from gate.in-addr.de ([212.8.193.158]:9104 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262319AbTKNKQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 05:16:43 -0500
Date: Fri, 14 Nov 2003 11:16:47 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>, Daniel Gryniewicz <dang@fprintf.net>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [RFCI] How best to partition MD/raid devices in 2.6
Message-ID: <20031114101647.GJ32211@marowsky-bree.de>
References: <16308.18387.142415.469027@notabene.cse.unsw.edu.au> <1068787304.4157.8.camel@localhost> <16308.26754.867801.131463@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16308.26754.867801.131463@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-11-14T16:30:42,
   Neil Brown <neilb@cse.unsw.edu.au> said:

> There are issues with the raid superblock but assuming they can be
> solved, I want partitioning to work easily.
> 
> Can LVM work happily with 'legacy' partitioning information?

I'd really suggest to run DM (either LVM2 or EVMS2) on top of md
instead. It's much more flexible; I don't see any benefit in 'old style'
partition information, which has all sorts of problems - ie,
non-transactional updates (_why_ were you running raid again? ;), static
as they can't be modified during runtime etc.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

