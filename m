Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWHBTK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWHBTK6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWHBTK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:10:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:40901 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932149AbWHBTK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:10:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=HUUSwlbsi7wdMHJB2LIeLP0SZgKUwehWg7CXrkD9KEjckngpQrCZk67rwU8Kxm+00/KdeGcTL/r6I75We4gVR2BBm/UnngE07mxV/5HZG4fcV0RKKPLAEKy6J4sgcuMPbiyOYRDPRgN6iCEpJ+xKeyT7+0nkYEbyL1SJiXOlD/w=
Date: Wed, 2 Aug 2006 23:10:54 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs.h: ifdef security fields
Message-ID: <20060802191054.GA6825@martell.zuzino.mipt.ru>
References: <20060801155305.GA6872@martell.zuzino.mipt.ru> <1154458395.3582.150.camel@moss-spartans.epoch.ncsc.mil> <20060802151455.GA6827@martell.zuzino.mipt.ru> <1154537585.16917.114.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154537585.16917.114.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 12:53:05PM -0400, Stephen Smalley wrote:
> On Wed, 2006-08-02 at 19:14 +0400, Alexey Dobriyan wrote:
> > > > --- a/include/linux/fs.h
> > > > +++ b/include/linux/fs.h
> > > > @@ -552,7 +552,9 @@ struct inode {
> > > >  	unsigned int		i_flags;
> > > >
> > > >  	atomic_t		i_writecount;
> > > > +#ifdef CONFIG_SECURITY
> > > >  	void			*i_security;
> > > > +#endif
> > > >  	union {
> > > >  		void		*generic_ip;
> > > >  	} u;
> > > > @@ -688,8 +690,9 @@ struct file {
> > > >  	struct file_ra_state	f_ra;
> > > >
> > > >  	unsigned long		f_version;
> > > > +#ifdef CONFIG_SECURITY_SELINUX
> > >
> > > This should just be CONFIG_SECURITY.
> > 
> > After another user appear.
> 
> I see.  Well, if that's the rationale, I thought that seclvl was also
> scheduled for removal in 2.6.18 with the agreement of its maintainer, so
> that would also apply to i_security.

OK, I see seclvl removal patch has been sent and have found couple more
highly greppable fields: "security". :-) There will be bigger patch.

