Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWFNQsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWFNQsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 12:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWFNQsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 12:48:13 -0400
Received: from cantor2.suse.de ([195.135.220.15]:33182 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932099AbWFNQsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 12:48:12 -0400
Date: Wed, 14 Jun 2006 09:45:33 -0700
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: mp3@de.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: statistics infrastructure (in -mm tree) review
Message-ID: <20060614164533.GA4238@kroah.com>
References: <20060613232131.GA30196@kroah.com> <20060613234739.GA30534@kroah.com> <20060613171827.73cd0688.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060613171827.73cd0688.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2006 at 05:18:27PM -0700, Randy.Dunlap wrote:
> On Tue, 13 Jun 2006 16:47:39 -0700 Greg KH wrote:
> > > +/**
> > > + * struct statistic_info - description of a class of statistics
> > > + * @name: pointer to name name string
> > > + * @x_unit: pointer to string describing unit of X of (X, Y) data pair
> > > + * @y_unit: pointer to string describing unit of Y of (X, Y) data pair
> > > + * @flags: only flag so far (distinction of incremental and other statistic)
> > > + * @defaults: pointer to string describing defaults setting for attributes
> > > + *
> > > + * Exploiters must setup an array of struct statistic_info for a
> > > + * corresponding array of struct statistic, which are then pointed to
> > > + * by struct statistic_interface.
> > > + *
> > > + * Struct statistic_info and all members and addressed strings must stay for
> > > + * the lifetime of corresponding statistics created with statistic_create().
> > > + *
> > > + * Except for the name string, all other members may be left blank.
> > > + * It would be nice of exploiters to fill it out completely, though.
> > > + */
> > > +struct statistic_info {
> > > +/* public: */
> > > +	char *name;
> > > +	char *x_unit;
> > > +	char *y_unit;
> > > +	int  flags;
> > > +	char *defaults;
> > > +};
> > 
> > The whole "public:" and "private:" thing in these structures is not
> > needed.  Just document it in the kernel-doc comments and you should be
> > fine.  This isn't C++ :)
> 
> but public: and private: are kernel-doc comments...
> Using "private:" causes those fields to be omitted from the
> generated documentation because those fields are for internal/private
> use of the (statistics) infrastructure code, not to be used by
> its clients (er, ugh, exploiters) etc.

Oh, I didn't realize that kerneldoc could do that now, nice.  And look,
it's even documented that it can support that, I'll shut up now :)

thanks,

greg k-h
