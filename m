Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263397AbTH0OlF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 10:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263399AbTH0OlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 10:41:05 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:6034 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S263397AbTH0OlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 10:41:02 -0400
Date: Wed, 27 Aug 2003 16:41:01 +0200
From: bert hubert <ahu@ds9a.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
Message-ID: <20030827144101.GA31458@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrew Morton <akpm@osdl.org>,
	Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
References: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au> <20030826181807.1edb8c48.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826181807.1edb8c48.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 06:18:07PM -0700, Andrew Morton wrote:

> >  always zero.  The appended patch adds fields to struct task_struct to
> >  count context switches, and adds code to do the counting.

> OK...  Why is this useful?  A bit of googling doesn't show much interest in
> it.

I'm unaware of the cost of accounting this, but I for one have had
occasions where my system was reporting 20kcs, and I had no clue which
process was causing it. After a while I learned that linuxthreads on SMP can
cause this.

> What apps should be reporting this info?  /usr/bin/time?

/proc/$$/stat would also be nice.

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
