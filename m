Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263804AbUEHBDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbUEHBDw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 21:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUEHBDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 21:03:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:27346 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263804AbUEHBDu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 21:03:50 -0400
Subject: Re: [PATCH] dentry and inode cache hash algorithm performance
	changes.
From: Dave Hansen <haveblue@us.ibm.com>
To: "Jose R. Santos" <jrsantos@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, dheger@us.ibm.com,
       slpratt@us.ibm.com
In-Reply-To: <20040507130415.GA1537@rx8.ibm.com>
References: <20040430191539.GC14271@rx8.ibm.com>
	 <20040430131832.45be6956.akpm@osdl.org>
	 <20040430205701.GG14271@rx8.ibm.com> <20040430213324.GK14271@rx8.ibm.com>
	 <20040430150256.25735762.akpm@osdl.org>
	 <20040504131223.GA28009@austin.ibm.com>
	 <20040504115510.696184dc.akpm@osdl.org> <20040507130415.GA1537@rx8.ibm.com>
Content-Type: text/plain
Message-Id: <1083978219.28602.28.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 07 May 2004 18:03:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-07 at 06:04, Jose R. Santos wrote:
> On 05/04/04 13:55:10, Andrew Morton wrote:
> > > Andrew - Is there any workload you want me to run to show that this hash
> > > function is going to be equal or better that the one already provided
> > > in Linux?
> > 
> > Not really - it sounds like you've covered it pretty well.  Did you try SDET?
> > 
> > It could be that reducing the hash table size will turn pretty much any
> > workload into a test of the hash quality.
> 
> Sorry for the late reply...
> 
> Steve Pratt seem to have a SDET setup already and he did me the favor of 
> running SDET with a reduce dentry entry hash table size.  I belive that
> his table suggest that less than 3% change is acceptable variability, but
> overall he got a 5% better number using the new hash algorith.

It's usually best to keep increasing the number of SDET iterations that
you average against, at least until the averages start to become a bit
less bouncy.  Also, mounting ramfs on /tmp can _really_ help lower its
variability, probably because of gcc.  

You might be lucky enough to get some consistently good numbers that
way.

-- Dave

