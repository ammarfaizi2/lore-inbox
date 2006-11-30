Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967832AbWK3PEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967832AbWK3PEt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 10:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967834AbWK3PEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 10:04:49 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:51346 "EHLO
	adelie.ubuntu.com") by vger.kernel.org with ESMTP id S967832AbWK3PEs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 10:04:48 -0500
Subject: Re: [PATCH 4/4] [HVCS] Select HVC_CONSOLE if HVCS is enabled.
From: Ben Collins <ben.collins@ubuntu.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.64.0611301331520.6243@scrub.home>
References: <11648607683157-git-send-email-bcollins@ubuntu.com>
	 <1164860773166-git-send-email-bcollins@ubuntu.com>
	 <Pine.LNX.4.64.0611301331520.6243@scrub.home>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Nov 2006 10:04:44 -0500
Message-Id: <1164899084.5257.806.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-30 at 13:32 +0100, Roman Zippel wrote:
> Hi,
> 
> On Wed, 29 Nov 2006, Ben Collins wrote:
> 
> > If HVC_CONSOLE provides symbols that HVCS requires.
> > 
> > Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> > ---
> >  drivers/char/Kconfig |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> > index 2af12fc..c94ecdc 100644
> > --- a/drivers/char/Kconfig
> > +++ b/drivers/char/Kconfig
> > @@ -598,6 +598,7 @@ config HVC_RTAS
> >  config HVCS
> >  	tristate "IBM Hypervisor Virtual Console Server support"
> >  	depends on PPC_PSERIES
> > +	select HVC_CONSOLE
> >  	help
> >  	  Partitionable IBM Power5 ppc64 machines allow hosting of
> >  	  firmware virtual consoles from one Linux partition by
> 
> 
> Why not a normal dependency?

Most of the HVC options are doing select on other HVC things (like
select HVC_DRIVER). So if this one needs to be a dependency, then it
would make more sense to clean up the HVC option group to do the same. I
just did the one-liner to make it work.
