Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVC3FkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVC3FkP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 00:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVC3FkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 00:40:14 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:39405 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261289AbVC3Fj4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 00:39:56 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@engr.sgi.com>, Erich Focht <efocht@hpce.nec.com>,
       Ram <linuxram@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <20050329072335.52b06462.pj@engr.sgi.com>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	 <20050328134242.4c6f7583.pj@engr.sgi.com> <1112079856.5243.24.camel@uganda>
	 <20050329004915.27cd0edf.pj@engr.sgi.com>
	 <1112087822.8426.46.camel@frecb000711.frec.bull.fr>
	 <20050329072335.52b06462.pj@engr.sgi.com>
Date: Wed, 30 Mar 2005 07:39:43 +0200
Message-Id: <1112161183.20919.84.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/03/2005 07:49:29,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/03/2005 07:49:32,
	Serialize complete at 30/03/2005 07:49:32
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 07:23 -0800, Paul Jackson wrote:
> Guillaume wrote:
> >   The goal of the fork connector is to inform a user space application
> > that a fork occurs in the kernel. This information (cpu ID, parent PID
> > and child PID) can be used by several user space applications. It's not
> > only for accounting. Accounting and fork_connector are two different
> > things and thus, fork_connector doesn't do the merge of any kinds of
> > data (and it will never do). 
> 
> Yes - it is clear that the fork_connector does this - inform user space
> of fork information <cpu, parent, child>.  I'm not saying that
> fork_connector should merge data; I'm observing that it doesn't, and
> that this would seem to serve the needs of accounting poorly.
> 
> Out of curiosity, what are these 'several user space applications?'  The
> only one I know of is this extension to bsd accounting to include
> capturing parent and child pid at fork.  Probably you've mentioned some
> other uses of fork_connector before here, but I missed it.

During the discussion some people like Erich Focht and Ram mentioned
that this information can be useful for them. I remember that Erich had
in mind something like cluster-wide pid tracking in user space. 

When I wrote "several user space applications" it was just to say that
this fork connector is not designed only for ELSA and fork information
is available to every listeners.

Regards,
Guillaume

