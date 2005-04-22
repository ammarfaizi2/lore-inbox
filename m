Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVDVVig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVDVVig (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 17:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVDVVig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 17:38:36 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:14725 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262140AbVDVVic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 17:38:32 -0400
Date: Fri, 22 Apr 2005 14:37:51 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: dino@in.ibm.com, Simon.Derr@bull.net, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       akpm@osdl.org, dipankar@in.ibm.com, colpatch@us.ibm.com
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets (v0.2)
Message-Id: <20050422143751.36d0e7af.pj@sgi.com>
In-Reply-To: <20050422115055.5c5b9e25.pj@sgi.com>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
	<20050421173135.GB4200@in.ibm.com>
	<20050422115055.5c5b9e25.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is the above code equivalant to what the comment states:
> 
> 	if (is_cpu_isolated(trial) <= is_cpu_exclusive(trial))
> 		return -EINVAL;

I think I got that backwards.  How about:

	/* An isolated cpuset has to be exclusive */
	if (!(is_cpu_isolated(trial) <= is_cpu_exclusive(trial)))
		return -EINVAL;

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
