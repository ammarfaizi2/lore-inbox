Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbTITLJg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 07:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTITLJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 07:09:36 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:37864 "EHLO
	iramx2.ira.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S261831AbTITLJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 07:09:35 -0400
Date: Sat, 20 Sep 2003 13:09:28 +0200
From: Roland Bless <bless@tm.uka.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Roland Bless <bless@tm.uka.de>, miquels@cistron.nl,
       linux-kernel@vger.kernel.org, walter@tm.uka.de, winter@tm.uka.de,
       doll@tm.uka.de
Subject: Re: Fix for wrong OOM killer trigger?
Message-ID: <20030920110928.GA24934@vorta.ipv6.tm.uka.de>
References: <20030919191613.36750de3.bless@tm.uka.de> <20030919192544.GC1312@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030919192544.GC1312@velociraptor.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 09:25:44PM +0200, Andrea Arcangeli wrote:
> 
> can you try with 2.4.22aa1? the oom killer there will only work on tasks
> that are allocating memory, not on idle daemons, so the probability of
> killing rsync first should be higher. stock SuSE 8.1 kernel should do
> the same too.

This will only help to avoid not shooting important daemons.
The real cause, however, seems to be that the filesystem cache
memory is not properly re-used when it should, or, that it tries to
allocate a huge amount memory. The programs themselves do not
allocate much memory! It must be the system, because I also
ran programs with memory restrictions by ulimit. The programs
are definitely not allocating the memory, and, 4GB RAM are really
enough for a simple file server like ours.

Regards,
 Roland
