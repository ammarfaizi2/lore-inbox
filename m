Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266871AbUH0SQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266871AbUH0SQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266876AbUH0SQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:16:57 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:22935 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266871AbUH0SPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:15:52 -0400
Message-ID: <412F7A59.8060508@namesys.com>
Date: Fri, 27 Aug 2004 11:15:53 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: Christoph Hellwig <hch@lst.de>, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
References: <20040825152805.45a1ce64.akpm@osdl.org>	<412D9FE6.9050307@namesys.com>	<20040826014542.4bfe7cc3.akpm@osdl.org>	<1093522729.9004.40.camel@leto.cs.pocnet.net>	<20040826124929.GA542@lst.de>	<1093525234.9004.55.camel@leto.cs.pocnet.net>	<20040826130718.GB820@lst.de>	<1093526273.11694.8.camel@leto.cs.pocnet.net>	<20040826132439.GA1188@lst.de>	<1093527307.11694.23.camel@leto.cs.pocnet.net>	<20040826134034.GA1470@lst.de>	<1093528683.11694.36.camel@leto.cs.pocnet.net>	<412E786E.5080608@namesys.com> <16687.9051.311225.697109@thebsh.namesys.com>
In-Reply-To: <16687.9051.311225.697109@thebsh.namesys.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Hans Reiser writes:
> > Christophe Saout wrote:
> > 
> > >
> > >
> > >I don't know, ask Hans. How could the VFS know it a filesystem wants to
> > >do something specific with a file that is completely transparent to the
> > >VFS?
> > >
> > >  
> > >
> > To know what method to use, you must determine the pluginid, and then 
> > find the method within that plugin for that vfs operation.
> > 
> > As for overhead, well, who eats whose dust in the benchmarks....?
>
>Whoever sponsors the benchmark usually wins. Had you forgotten that
>mongo setup used by http://www.namesys.com/benchmarks.html was specially
>`tuned' to reach peak reiser4 performance? Remember why you decided to
>turn OVERWRITE and MODIFY phases off? People on #reiser4 report 90
>_second_ stalls with reiser4 under high io loads (large atom is
>obviously being flushed and everyone waits on it...). In my opinion, it
>is such things that are of utmost importance for real reiser4
>acceptance, not how to name `metas' sub-directory.
>
>Nikita.
>
>
>  
>
If you ask real users, they say that reiser4 is fast, and their 
experience matches our benchmark.  You can criticize the benchmark if 
you want, but then you should run your own and publish it.

There are still plenty of things needing fixing though, and you are 
right that they are more important than the pretext being attempted for 
keeping us out of the kernel.  Probably you could supply them with many 
superior pretexts.;-)

The 90 second stalls, those should be fixed by debugging copy on capture 
and turning it on, yes?  You can hardly claim I failed to push for the 
completion of copy on capture....  and of course the reason it is not 
done is simply that there is too much to do....  I (sincerely) hope vs 
enjoys his vacation, the whole team is working too hard.  I am doing 7 
day weeks now to try to make payroll for us and keep darpa happy at the 
same time.

fsync performance needs fixing badly, and Chris is right in his 
diagnosis of what we can do to fix it.

Hans
