Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVEBXWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVEBXWS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 19:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVEBXWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 19:22:18 -0400
Received: from smtp.istop.com ([66.11.167.126]:2774 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261220AbVEBXWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 19:22:12 -0400
From: Daniel Phillips <phillips@istop.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [PATCH 1b/7] dlm: core locking
Date: Mon, 2 May 2005 19:23:30 -0400
User-Agent: KMail/1.7
Cc: Daniel McNeil <daniel@osdl.org>, David Teigland <teigland@redhat.com>,
       Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <20050425165826.GB11938@redhat.com> <200504290425.24485.phillips@istop.com> <20050502204514.GB4722@marowsky-bree.de>
In-Reply-To: <20050502204514.GB4722@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505021923.30394.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 May 2005 16:45, Lars Marowsky-Bree wrote:
> On 2005-04-29T04:25:24, Daniel Phillips <phillips@istop.com> wrote:
> > > It makes a whole lot of sense to combine a DLM with (appropriate)
> > > fencing so that the shared resources are protected. I understood
> > > David's comment to rather imply that fencing is assumed to happen
> > > outside the DLM's world in a different component; ie more of a comment
> > > on sane modularization instead of sane real-world configuration.
> >
> > But just because fencing is supposed to happen in an external component,
> > we can't wave our hands at it and skip the analysis.  We _must_ identify
> > the fencing assumptions and trace the fencing paths with respect to every
> > recovery algorithm in every cluster component, including the dlm.
>
> "A fenced node no longer has access to any shared resource".
>
> Is there any other assumption you have in mind?

Nice problem statement.  Now we just need to see the proof that we satisfy 
this requirement for every cluster service, application, block device, etc 
for every possible cluster configuration and normal or failure state.

My assumption is that we will achieve this in a way that is efficient, easy to 
configure and not prone to deadlock, with emphasis on the "will".

Regards,

Daniel
