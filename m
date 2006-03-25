Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751627AbWCYByS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWCYByS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 20:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWCYByS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 20:54:18 -0500
Received: from mail13.bluewin.ch ([195.186.18.62]:61825 "EHLO
	mail13.bluewin.ch") by vger.kernel.org with ESMTP id S1751625AbWCYByS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 20:54:18 -0500
Date: Fri, 24 Mar 2006 20:53:27 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, p_gortmaker@yahoo.com, jgarzik@pobox.com
Subject: Re: -mm merge plans
Message-ID: <20060325015327.GA30484@krypton>
References: <20060322205305.0604f49b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322205305.0604f49b.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
From: apgo@patchbomb.org (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 08:53:05PM -0800, Andrew Morton wrote:
> 
> A look at the -mm lineup for 2.6.17:
 
[snip]

> net-remove-config_net_cbus-conditional-for-ns8390.patch
 
On Sun, Feb 19, 2006 at 08:26:25AM -0800, Paul Gortmaker wrote:
> Fine by me. 
> 
> Paul.
> 
> Signed-off-by: Paul Gortmaker <p_gortmaker@yahoo.com>
> 
> --- Arthur Othieno <apgo@patchbomb.org> wrote:
> 
> > Don't bother testing for CONFIG_NET_CBUS ("NEC PC-9800 C-bus cards");
> > it went out with the rest of PC98 subarch.
> > 
> > Signed-off-by: Arthur Othieno <apgo@patchbomb.org>
> > 
> > ---
> > 
> >  drivers/net/8390.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > 6eca48257ddfe560447fda2c0c1961d78b06a047
> > diff --git a/drivers/net/8390.h b/drivers/net/8390.h
> > index 599b68d..51e39dc 100644
> > --- a/drivers/net/8390.h
> > +++ b/drivers/net/8390.h
> > @@ -134,7 +134,7 @@ struct ei_device {
> >  #define inb_p(_p)	inb(_p)
> >  #define outb_p(_v,_p)	outb(_v,_p)
> >  
> > -#elif defined(CONFIG_NET_CBUS) || defined(CONFIG_NE_H8300) ||
> > defined(CONFIG_NE_H8300_MODULE)
> > +#elif defined(CONFIG_NE_H8300) || defined(CONFIG_NE_H8300_MODULE)
> >  #define EI_SHIFT(x)	(ei_local->reg_offset[x])
> >  #else
> >  #define EI_SHIFT(x)	(x)
> > -- 
> > 1.1.5
