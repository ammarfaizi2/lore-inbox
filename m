Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTELPCK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 11:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTELPCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 11:02:09 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:41209 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262192AbTELPCC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 11:02:02 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Ragnar =?iso-8859-1?q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
Subject: Re: The disappearing sys_call_table export.
Date: Mon, 12 May 2003 09:19:25 -0500
X-Mailer: KMail [version 1.2]
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200305081546_MC3-1-3809-363E@compuserve.com> <03050908530400.11221@tabby> <20030509143715.GC16354@vestdata.no>
In-Reply-To: <20030509143715.GC16354@vestdata.no>
MIME-Version: 1.0
Message-Id: <03051209192501.16618@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 May 2003 09:37, Ragnar Kjørstad wrote:
> On Fri, May 09, 2003 at 08:53:04AM -0500, Jesse Pollard wrote:
> > On Thursday 08 May 2003 14:43, Chuck Ebbert wrote:
> > > > Have you tried catching the display IO ???
> > >
> > >   Not in a million years -- display drivers work by pure magic AFAIC.
> > >
> > > > HSM has existed on UNIX based machines for a long time.
> > >
> > >   Show me three HSM implementations for Linux and I'll show you three
> > > different mechanisms. :)
> >
> > Actually... I think they all use the same one (Even the Solaris/IRIX/Cray
> > ones do that). All of them provide a filesystem interface via VFS. The
> > Linux ones were implemented via the "userfs" core or NFS.
>
> I'm not sure what you mean by "via" VFS, but most HSM implementations on
> linux require extra interfaces and special support in the filesystem (XDSM
> or propriatary).

All of the HSM systems I've used had the XDSM handled outside the kernel.
The only thing actually IN the kernel was the VFS module to intercept the
VFS calls (like userfs did) and then pass them to an external daemon to 
retrieve the data of migrated files. In the two cases, the rest of the 
filesystem was implemented within the VFS module. One case I've read about,
(datatree??? something like that) used an NFS interface to allow it to pass
the requests on to a non-HSM filesystem when the data was put on disk.

> The only exceptions I know are openXDSM which was intended to be a
> generic interface in the VFS-layer (but we never got time to implement
> it) and a implementation based on stackable filesystem.
>
> I don't know if the later is actually in use anywere, or if it is
> abandoned.

I don't know either, but all XDSM was to do was support the user mode
infrastructure behind the VFS module.
