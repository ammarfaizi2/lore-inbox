Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWJDVhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWJDVhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWJDVhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:37:08 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:49645 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751159AbWJDVhG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:37:06 -0400
Subject: Re: [RFC][PATCH 0/4] Generic container system
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Martin Bligh <mbligh@google.com>
Cc: Paul Menage <menage@google.com>, pj@sgi.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       winget@google.com, rohitseth@google.com, jlan@sgi.com,
       Joel.Becker@oracle.com, Simon.Derr@bull.net
In-Reply-To: <45240D20.3080202@google.com>
References: <20061002095319.865614000@menage.corp.google.com>
	 <1159925752.24266.22.camel@linuxchandra>
	 <6599ad830610031934s41994158o59f1a2e58b1cb45e@mail.gmail.com>
	 <1159988217.24266.60.camel@linuxchandra>  <45240D20.3080202@google.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 04 Oct 2006 14:37:01 -0700
Message-Id: <1159997821.24266.62.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 12:36 -0700, Martin Bligh wrote:

I agree with you, Martin.

> >>It would certainly be possible to have finer-grained locking. But the
> >>cpuset code seems pretty happy with coarse-grained locking (only one
> > 
> > 
> > cpuset may be happy today. But, It will not be happy when there are tens
> > of other container subsystems use the same locks to protect their own
> > data structures. Using such coarse locking will certainly affect the
> > scalability.
> 
> All of this (and the rest of the snipped email with suggested
> improvements) makes pretty good sense. But would it not be better
> to do this in stages?
> 
> 1) Split the code out from cpusets

Paul (Menage) is already work on this.

We will work out the rest.
> 2) Move to configfs
> 3) Work on locking scalability, etc ...
> 
> Else it'd seem that we'll never get anywhere, and it'll all be
> impossible to review anyway. Incremental improvement would seem to
> be a much easier way to fix this stuff, to me.
> 
> M.
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


