Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUH0MEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUH0MEs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 08:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUH0MEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 08:04:48 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:19596 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263784AbUH0MEo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 08:04:44 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16687.9051.311225.697109@thebsh.namesys.com>
Date: Fri, 27 Aug 2004 16:04:43 +0400
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@lst.de>, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
In-Reply-To: <412E786E.5080608@namesys.com>
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
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:
 > Christophe Saout wrote:
 > 
 > >
 > >
 > >I don't know, ask Hans. How could the VFS know it a filesystem wants to
 > >do something specific with a file that is completely transparent to the
 > >VFS?
 > >
 > >  
 > >
 > To know what method to use, you must determine the pluginid, and then 
 > find the method within that plugin for that vfs operation.
 > 
 > As for overhead, well, who eats whose dust in the benchmarks....?

Whoever sponsors the benchmark usually wins. Had you forgotten that
mongo setup used by http://www.namesys.com/benchmarks.html was specially
`tuned' to reach peak reiser4 performance? Remember why you decided to
turn OVERWRITE and MODIFY phases off? People on #reiser4 report 90
_second_ stalls with reiser4 under high io loads (large atom is
obviously being flushed and everyone waits on it...). In my opinion, it
is such things that are of utmost importance for real reiser4
acceptance, not how to name `metas' sub-directory.

Nikita.
