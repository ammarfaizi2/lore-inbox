Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161129AbVKDKFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbVKDKFH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 05:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbVKDKFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 05:05:06 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14515 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161129AbVKDKFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 05:05:05 -0500
Date: Fri, 4 Nov 2005 02:04:29 -0800
From: Paul Jackson <pj@sgi.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, mingo@elte.hu, pbadari@gmail.com, torvalds@osdl.org,
       jdike@addtoit.com, rob@landley.net, nickpiggin@yahoo.com.au,
       gh@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com, haveblue@us.ibm.com,
       mel@csn.ul.ie, mbligh@mbligh.org, kravetz@us.ibm.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [patch] swapin rlimit
Message-Id: <20051104020429.104c27b3.pj@sgi.com>
In-Reply-To: <1131092322.2799.3.camel@laptopd505.fenrus.org>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com>
	<200511021747.45599.rob@landley.net>
	<43699573.4070301@yahoo.com.au>
	<200511030007.34285.rob@landley.net>
	<20051103163555.GA4174@ccure.user-mode-linux.org>
	<1131035000.24503.135.camel@localhost.localdomain>
	<20051103205202.4417acf4.akpm@osdl.org>
	<20051104072628.GA20108@elte.hu>
	<20051103233628.12ed1eee.akpm@osdl.org>
	<1131092322.2799.3.camel@laptopd505.fenrus.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan wrote:
> doing this from userspace is tricky; what if the task dies of natural
> causes and the pid gets reused, between the time the userspace app reads
> the value and the time it decides the time is up and time for a kill....
> (and on a busy server that can be quite a bit of time)

If pids are being reused within seconds of their being freed up,
then the batch managers running on the big HPC systems I care
about are so screwed it isn't even funny.  They depend heavily
on being able to identify the task pids in a job and then doing
something to those tasks (suspend, kill, gather stats, ...).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
