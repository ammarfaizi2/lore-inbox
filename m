Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWHBQui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWHBQui (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWHBQui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:50:38 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:55001 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750950AbWHBQui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:50:38 -0400
Subject: Re: [PATCH v2] fs.h: ifdef security fields
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060802151455.GA6827@martell.zuzino.mipt.ru>
References: <20060801155305.GA6872@martell.zuzino.mipt.ru>
	 <1154458395.3582.150.camel@moss-spartans.epoch.ncsc.mil>
	 <20060802151455.GA6827@martell.zuzino.mipt.ru>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 02 Aug 2006 12:53:05 -0400
Message-Id: <1154537585.16917.114.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-02 at 19:14 +0400, Alexey Dobriyan wrote:
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -552,7 +552,9 @@ struct inode {
> > >  	unsigned int		i_flags;
> > >
> > >  	atomic_t		i_writecount;
> > > +#ifdef CONFIG_SECURITY
> > >  	void			*i_security;
> > > +#endif
> > >  	union {
> > >  		void		*generic_ip;
> > >  	} u;
> > > @@ -688,8 +690,9 @@ struct file {
> > >  	struct file_ra_state	f_ra;
> > >
> > >  	unsigned long		f_version;
> > > +#ifdef CONFIG_SECURITY_SELINUX
> >
> > This should just be CONFIG_SECURITY.
> 
> After another user appear.

I see.  Well, if that's the rationale, I thought that seclvl was also
scheduled for removal in 2.6.18 with the agreement of its maintainer, so
that would also apply to i_security.

-- 
Stephen Smalley
National Security Agency

