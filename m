Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWESRQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWESRQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 13:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWESRQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 13:16:46 -0400
Received: from hera.kernel.org ([140.211.167.34]:56713 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751399AbWESRQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 13:16:45 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 0/9] namespaces: Introduction
Date: Fri, 19 May 2006 10:15:47 -0700
Organization: OSDL
Message-ID: <20060519101547.2614ec60@localhost.localdomain>
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<20060518103430.080e3523.akpm@osdl.org>
	<20060519124235.GA32304@MAIL.13thfloor.at>
	<20060519081334.06ce452d.akpm@osdl.org>
	<m1iro2yo7f.fsf@ebiederm.dsl.xmission.com>
	<20060519094047.425dced1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1148058946 17047 10.8.0.54 (19 May 2006 17:15:46 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 19 May 2006 17:15:46 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2006 09:40:47 -0700
Andrew Morton <akpm@osdl.org> wrote:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
> >
> >  > Herbert Poetzl <herbert@13thfloor.at> wrote:
> >  >>
> >  >> let me
> >  >>  give a simple example here:
> >  >
> >  > Examples are useful.
> >  >
> >  >>   "pid virtualization"
> >  >> 
> >  >>   - Linux-VServer doesn't really need that right now.
> >  >>     we are perfectly fine with "pid isolation" here, we
> >  >>     only "virtualize" the init pid to make pstree happy
> >  >> 
> >  >>   - Snapshot/Restart and Migration will require "full"
> >  >>     pid virtualization (that's where Eric and OpenVZ
> >  >>     are heading towards)
> >  >
> >  > snapshot/restart/migration worry me.  If they require complete
> >  > serialisation of complex kernel data structures then we have a problem,
> >  > because it means that any time anyone changes such a structure they need to
> >  > update (and test) the serialisation.
> > 
> >  There is a strict limit to what is user visible, and if it isn't user visible
> >  we will never need it in a checkpoint.  So internal implementation details
> >  should not matter.
> 
> Migration of currently-open sockets (for example) would require storing of
> a lot of state, wouldn't it?

Werner has demonstrated TCP connection passing
	http://tcpcp.sourceforge.net/
