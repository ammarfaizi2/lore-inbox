Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265329AbTFMKHy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 06:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265330AbTFMKHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 06:07:54 -0400
Received: from uni00du.unity.ncsu.edu ([152.1.13.100]:3712 "EHLO
	uni00du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S265329AbTFMKHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 06:07:52 -0400
From: jlnance@unity.ncsu.edu
Date: Fri, 13 Jun 2003 06:21:39 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: limit resident memory size
Message-ID: <20030613102139.GA769@ncsu.edu>
References: <20030612205557.5874.qmail@web40602.mail.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOEBMDKAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKOEBMDKAA.davids@webmaster.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 03:15:13PM -0700, David Schwartz wrote:
> 
> > I would like to limit the maximum resident memory size
> > of a process within a threshold, i.e. if its virtual
> > memory footprint exceeds this threshold, it needs to
> > swap out pages *only* from within its VM space.
> 
> 	Why? If you think this is a good way to be nice to other
>	processes, you're wrong.

I have to disagree.  I used to use a Digital Unix system, which had this
feature, to do software development.  The program I was working on was
large, and linking it required more memory than the 128M that was installed
on the computer.  All my makes ended with a 10 minute swap storm during
which the computer was virtually useless.

I discovered that if I limited the RSS of the link process so that it left
a few megs of memory free then I could read mail or look around the web
while the link was running.  This of course slowed down the link, but I
was supprised by how little it suffered.  It might have been 10% slower
and the tradeoff I got was to be able to use the machine while it was
working rather than sitting there looking at it.

Thanks,

Jim
