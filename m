Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbVJBOlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVJBOlT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 10:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVJBOlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 10:41:19 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1287 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751096AbVJBOlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 10:41:18 -0400
Date: Sun, 2 Oct 2005 16:41:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: David Miller <davem@davemloft.net>, neilb@cse.unsw.edu.au,
       trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] net/sunrpc/: possible cleanups
Message-ID: <20051002144113.GM4212@stusta.de>
References: <20051001142041.GB4212@stusta.de> <20051001164019.GB8633@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051001164019.GB8633@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2005 at 08:40:19PM +0400, Alexey Dobriyan wrote:
> On Sat, Oct 01, 2005 at 04:20:41PM +0200, Adrian Bunk wrote:
> > -/* Just increments the mechanism's reference count and returns its input: */
> > -struct gss_api_mech * gss_mech_get(struct gss_api_mech *);
> > -
> 
> > -struct gss_api_mech *
> > +static struct gss_api_mech *
> >  gss_mech_get(struct gss_api_mech *gm)
> 
> Comment is lost.


The comment made sense for the prototype at the header, but the function 
now has only one caller in the file where it's defined.


If someone needs a comment to figure out what a function whose complete 
contents is

static struct gss_api_mech *
gss_mech_get(struct gss_api_mech *gm)
{
        __module_get(gm->gm_owner);
        return gm;
}

does, the problem is not a missing comment.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

