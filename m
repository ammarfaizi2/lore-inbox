Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWHHKgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWHHKgV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWHHKgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:36:20 -0400
Received: from cantor.suse.de ([195.135.220.2]:49127 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932531AbWHHKgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:36:20 -0400
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [RFC] NUMA futex hashing
Date: Tue, 8 Aug 2006 12:36:15 +0200
User-Agent: KMail/1.9.3
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
References: <20060808070708.GA3931@localhost.localdomain> <p73bqqvpn14.fsf@verdi.suse.de> <200608081210.40334.dada1@cosmosbay.com>
In-Reply-To: <200608081210.40334.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081236.15823.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> We may have special case for PRIVATE futexes (they dont need to be chained in 
> a global table, but a process private table)

What do you mean with PRIVATE futex? 

Even if the futex mapping is only visible by a single MM mmap_sem is still needed
to protect against other threads doing mmap.
 
-Andi
