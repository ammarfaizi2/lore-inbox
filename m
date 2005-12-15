Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVLOUCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVLOUCx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 15:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVLOUCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 15:02:53 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:53693 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750774AbVLOUCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 15:02:53 -0500
Subject: Re: [ckrm-tech] Re: [RFC][patch 00/21] PID Virtualization:
	Overview and Patches
From: Dave Hansen <haveblue@us.ibm.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, vserver@list.linux-vserver.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       pagg@oss.sgi.com
In-Reply-To: <E1Emz6c-0006c3-00@w-gerrit.beaverton.ibm.com>
References: <E1Emz6c-0006c3-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 12:02:41 -0800
Message-Id: <1134676961.22525.72.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 11:49 -0800, Gerrit Huizenga wrote:
> I think perhaps this could also be the basis for a CKRM "class"
> grouping as well.  Rather than maintaining an independent class
> affiliation for tasks, why not have a class devolve (evolve?) into
> a "container" as described here.

Wasn't one of the grand schemes of CKRM to be able to have application
instances be shared?  For instance, running a single DB2, Oracle, or
Apache server, and still accounting for all of the classes separately.
If so, that wouldn't work with a scheme that requires process
separation.

But, sharing the application instances is probably mostly (only)
important for databases anyway.  I would imagine that most of the
overhead in a server like an Apache instance is for the page cache for
content, as well as a bit for Apache's executables themselves.  The
container schemes should be able to share page cache for both cases.
The main issues would be managing multiple configurations, and the
increased overhead from having more processes around than with a single
server.

There might also be some serious restrictions on containerized
applications.  For instance, taking a running application, moving it out
of one container, and into another might not be feasible.  Is this
something that is common or desired in the current CKRM framework?

-- Dave

