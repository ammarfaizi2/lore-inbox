Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266371AbUFZL5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266371AbUFZL5z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 07:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUFZL5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 07:57:55 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:13839 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S266371AbUFZL5y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 07:57:54 -0400
Date: Sat, 26 Jun 2004 14:00:06 +0200
To: Amit Gud <gud@eth.net>
Cc: Timothy Miller <miller@techsource.com>, Pavel Machek <pavel@suse.cz>,
       alan <alan@clueserver.org>,
       "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS)
Message-ID: <20040626120006.GA14609@hh.idb.hist.no>
References: <20040624220318.GE20649@elf.ucw.cz> <Pine.LNX.4.44.0406241544010.19187-100000@www.fnordora.org> <20040625001545.GI20649@elf.ucw.cz> <40DC62BD.3010607@techsource.com> <40DC72A2.6080600@eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40DC72A2.6080600@eth.net>
User-Agent: Mutt/1.5.6+20040523i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 12:14:50AM +0530, Amit Gud wrote:
> Timothy Miller wrote:
> 
> >
> >I have a much simpler idea that both implements the EQFS and doesn't 
> >touch the kernel.
> >
> >Each user is given a quota which applies to their home directory.  
> >(This quota is not elastic and if everyone met their quota, everything 
> >would fit.)  In addition, there is another directory or file system 
> >(could be on the same disk or even the same partition) to which their 
> >quota doesn't apply AT ALL.  Let's call this "scratch" space.
> >
> I guess the system should be more transparent to the users and their 
> applications. Here its not convenient to generate .o files or caches in 
> /scratch/$USER/ .
> 
Symlinks.  I mozilla stores a cache in .mozilla/something,
then make .mozilla/something a symlink to /scratch/user/.mozilla/something

In a big installation, a script can do this for all users
as well as similiar tricks for other caching apps.

Helge Hafting
