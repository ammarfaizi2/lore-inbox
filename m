Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937904AbWLGBNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937904AbWLGBNN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 20:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937907AbWLGBNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 20:13:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3911 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S937904AbWLGBNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 20:13:11 -0500
Date: Thu, 7 Dec 2006 02:13:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Steven Whitehouse <swhiteho@redhat.com>, cluster-devel@redhat.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Patrick Caulfield <pcaulfie@redhat.com>
Subject: Re: [DLM] Fix DLM config [46/70]
Message-ID: <20061207011314.GA8963@stusta.de>
References: <1164889242.3752.397.camel@quoit.chygwyn.com> <20061206160342.494a3621.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206160342.494a3621.randy.dunlap@oracle.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 04:03:42PM -0800, Randy Dunlap wrote:
> On Thu, 30 Nov 2006 12:20:42 +0000 Steven Whitehouse wrote:
> 
> > >From b98c95af01c10827e3443157651eb469071391a3 Mon Sep 17 00:00:00 2001
> > From: Patrick Caulfield <pcaulfie@redhat.com>
> > Date: Wed, 15 Nov 2006 12:29:24 -0500
> > Subject: [PATCH] [DLM] Fix DLM config
> > 
> > The attached patch fixes the DLM config so that it selects the chosen network
> > transport. It should fix the bug where DLM can be left selected when NET gets
> > unselected. This incorporates all the comments received about this patch.
> > 
> > ---
> >  fs/dlm/Kconfig |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/fs/dlm/Kconfig b/fs/dlm/Kconfig
> > index c5985b8..b5654a2 100644
> > --- a/fs/dlm/Kconfig
> > +++ b/fs/dlm/Kconfig
> > @@ -1,10 +1,11 @@
> >  menu "Distributed Lock Manager"
> > -	depends on INET && IP_SCTP && EXPERIMENTAL
> > +	depends on EXPERIMENTAL && INET
> >  
> >  config DLM
> >  	tristate "Distributed Lock Manager (DLM)"
> >  	depends on IPV6 || IPV6=n
> 
> What does that "depends on" (above) mean???
>...

It's coming from the select'ed IP_SCTP:

SCTP has optional IPV6 support, and this handles IPV6=m, IP_SCTP=y by 
making it an illegal configuration.

> Thanks.
> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

