Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319645AbSH3SrU>; Fri, 30 Aug 2002 14:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319647AbSH3SrU>; Fri, 30 Aug 2002 14:47:20 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:39697 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S319645AbSH3SrT>; Fri, 30 Aug 2002 14:47:19 -0400
Message-ID: <3D6FBE41.3BC516BD@zip.com.au>
Date: Fri, 30 Aug 2002 11:49:37 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: [BUG+FIX] 2.4 buggercache sucks
References: <200208301121.06437.roy@karlsbakk.net> <30940000.1030727954@flay>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> >> Was your workload doing lots of reads, or lots of writes? Or both?
> >
> > I was downloading large files @ ~ 4Mbps from 20-50 clients - filesize ~3GB
> > the box has 1GB memory minus (no highmem) - so - 900 megs. After some time it
> > starts swapping and it OOMs. Same happens with several userspace httpd's
> 
> Mmmm .... not quite sure which way round to read that. Presumably the box
> that was the server fell over, and the clients are fine? So the workload that's
> causing problems is doing predominantly reads? If so, I suggest you tear down
> Andrew's patch to read side only, and submit that ... I get the feeling that would
> be acceptable, and would solve your problem.

But we still don't know what the problem _is_.  It's very weird.
