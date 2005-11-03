Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbVKCPkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbVKCPkV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbVKCPkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:40:20 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:44377 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030351AbVKCPkS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:40:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jx3P/tUkFOfBJ9WCxZ4jMJW7mcpXf/FIV98i2Dh5q6tUeWl+mn6EWuM5HjhQulbScLx/aevf5jg2oBrC79kinK85fmJb+bXS+QKLr6vU+694AhPkNAXhjqmHUEg70rsH14TQnFmuMU0hu+ZtcH2OPEFGsm+AkiRJmoldkgcQSg0=
Message-ID: <afcef88a0511030740r6464e7e3ia7467f0c58a459fa@mail.gmail.com>
Date: Thu, 3 Nov 2005 09:40:17 -0600
From: Michael Thompson <michael.craig.thompson@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 4/12: eCryptfs] Main module functions
Cc: Greg KH <greg@kroah.com>, Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
In-Reply-To: <20051103154726.GA7614@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051103033220.GD2772@sshock.rn.byu.edu>
	 <20051103034929.GD3005@sshock.rn.byu.edu>
	 <20051103060236.GB5044@kroah.com>
	 <afcef88a0511030709v1589ffe7s9052cd636d61c956@mail.gmail.com>
	 <20051103154726.GA7614@mipter.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Thu, Nov 03, 2005 at 09:09:24AM -0600, Michael Thompson wrote:
> > On 11/3/05, Greg KH <greg@kroah.com> wrote:
> > > > +/**
> > > > + * Module parameter that defines the ecryptfs_verbosity level.
> > > > + */
> > > > +#define VERBOSE_DUMP 9
> > > > +#ifdef DEBUG
> > > > +int ecryptfs_verbosity = VERBOSE_DUMP;
> > > > +#else
> > > > +int ecryptfs_verbosity = 1;
> > > > +#endif
> > > > +module_param(ecryptfs_verbosity, int, 1);
> > >
> > > I don't think you want a "1" here, do you?  Hint, it's not doing what
> > > you think it is doing...
> > Would you care to explain, providing its short, what it does? I don't
> > mind admitting I don't know everything, especially when it comes to
> > kernel code. If I am to RTFM, please point me to the right M. :)
>
> include/linux/moduleparam.h:#define module_param(name, type, perm)
>                                                              ^^^^
Thanks, my ability to read has improved. This will now be used properly :)
