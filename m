Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWESNar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWESNar (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 09:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWESNar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 09:30:47 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:52398 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932307AbWESNaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 09:30:46 -0400
Date: Fri, 19 May 2006 08:30:41 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       xemul@sw.ru, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH 0/9] namespaces: Introduction
Message-ID: <20060519133041.GC14317@sergelap.austin.ibm.com>
References: <20060518154700.GA28344@sergelap.austin.ibm.com> <m1sln61jqs.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1sln61jqs.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> > This patchset introduces a per-process utsname namespace.  These can
> > be used by openvz, vserver, and application migration to virtualize and
> > isolate utsname info (i.e. hostname).  More resources will follow, until
> > hopefully most or all vserver and openvz functionality can be implemented
> > by controlling resource namespaces from userspace.
> >
> > Previous utsname submissions placed a pointer to the utsname namespace
> > straight in the task_struct.  This patchset (and the last one) moves
> > it and the filesystem namespace pointer into struct nsproxy, which is
> > shared by processes sharing all namespaces.  The intent is to keep
> > the taskstruct smaller as the number of namespaces grows.
> 
> 
> Previously you mentioned:
> > BTW - a first set of comparison results showed nsproxy to have better
> > dbench and tbench throughput, and worse kernbench performance.  Which
> > may make sense given that nsproxy results in lower memory usage but
> > likely increased cache misses due to extra pointer dereference.
> 
> Is this still true?  Or did our final reference counting tweak fix
> the kernbench numbers?

I haven't checked that.  I'll start a new set of runs later this
morning, should get the results out saturday.

-serge
