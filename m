Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUH0S5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUH0S5R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUH0S5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:57:10 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:16617 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S267304AbUH0Szw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:55:52 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16687.33718.571411.76990@thebsh.namesys.com>
Date: Fri, 27 Aug 2004 22:55:50 +0400
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@lst.de>, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
In-Reply-To: <412F7A59.8060508@namesys.com>
References: <20040825152805.45a1ce64.akpm@osdl.org>
	<412D9FE6.9050307@namesys.com>
	<20040826014542.4bfe7cc3.akpm@osdl.org>
	<1093522729.9004.40.camel@leto.cs.pocnet.net>
	<20040826124929.GA542@lst.de>
	<1093525234.9004.55.camel@leto.cs.pocnet.net>
	<20040826130718.GB820@lst.de>
	<1093526273.11694.8.camel@leto.cs.pocnet.net>
	<20040826132439.GA1188@lst.de>
	<1093527307.11694.23.camel@leto.cs.pocnet.net>
	<20040826134034.GA1470@lst.de>
	<1093528683.11694.36.camel@leto.cs.pocnet.net>
	<412E786E.5080608@namesys.com>
	<16687.9051.311225.697109@thebsh.namesys.com>
	<412F7A59.8060508@namesys.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:
 > Nikita Danilov wrote:
 > 
 > >Hans Reiser writes:
 > > > Christophe Saout wrote:
 > > > 
 > > > >
 > > > >
 > > > >I don't know, ask Hans. How could the VFS know it a filesystem wants to
 > > > >do something specific with a file that is completely transparent to the
 > > > >VFS?
 > > > >
 > > > >  
 > > > >
 > > > To know what method to use, you must determine the pluginid, and then 
 > > > find the method within that plugin for that vfs operation.
 > > > 
 > > > As for overhead, well, who eats whose dust in the benchmarks....?
 > >
 > >Whoever sponsors the benchmark usually wins. Had you forgotten that
 > >mongo setup used by http://www.namesys.com/benchmarks.html was specially
 > >`tuned' to reach peak reiser4 performance? Remember why you decided to
 > >turn OVERWRITE and MODIFY phases off? People on #reiser4 report 90
 > >_second_ stalls with reiser4 under high io loads (large atom is
 > >obviously being flushed and everyone waits on it...). In my opinion, it
 > >is such things that are of utmost importance for real reiser4
 > >acceptance, not how to name `metas' sub-directory.
 > >
 > >Nikita.
 > >
 > >
 > >  
 > >
 > If you ask real users, they say that reiser4 is fast, and their 
 > experience matches our benchmark.  You can criticize the benchmark if 

They experience 90 second stalls. And please, do not tell me how fast
reiser4 is, I spent a lot of time working with it, and I know very well
when it's fast, and when it's deadly slow.

 > you want, but then you should run your own and publish it.

I did, after which you told me to turn OVERWRITE and MODIFY phases off,
beause performance was horrible.

I not criticizing mongo benchmark per se. I think that it is
fundamentally wrong to use results that were deliberatly manipulated to
get best appearance to reiser4 (by omitting work-loads where it performs
poorly) as an argument. It's not clear who will, according to your
colorful expression, `eat dust' as a result of this. Or do you think
that users never overwrite of modify files in real life?

 > The 90 second stalls, those should be fixed by debugging copy on capture 
 > and turning it on, yes?  You can hardly claim I failed to push for the 

No. I described so many times to you, why COC is ineffectual here.

 > Hans

Nikita.
