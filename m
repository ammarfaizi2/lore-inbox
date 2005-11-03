Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbVKCPeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbVKCPeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVKCPeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:34:22 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:677 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030320AbVKCPeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:34:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ScZHiszPKUOHYxTHK8we3Rq8WsQwqo6UJhiWGVn4+/ksXxcBbp9bbYcukNDlMF8/ck8m1VYLHGMg/gfGP3JUzpggunY3XaaAX/e29JB02A4LugoCVUATmihMwzoe8fm+rpIsd4jHRPrONLCF7K+6Mt1C+U1snfiVxBP0VWumANk=
Date: Thu, 3 Nov 2005 18:47:26 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Michael Thompson <michael.craig.thompson@gmail.com>
Cc: Greg KH <greg@kroah.com>, Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
Subject: Re: [PATCH 4/12: eCryptfs] Main module functions
Message-ID: <20051103154726.GA7614@mipter.zuzino.mipt.ru>
References: <20051103033220.GD2772@sshock.rn.byu.edu> <20051103034929.GD3005@sshock.rn.byu.edu> <20051103060236.GB5044@kroah.com> <afcef88a0511030709v1589ffe7s9052cd636d61c956@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afcef88a0511030709v1589ffe7s9052cd636d61c956@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 09:09:24AM -0600, Michael Thompson wrote:
> On 11/3/05, Greg KH <greg@kroah.com> wrote:
> > > +/**
> > > + * Module parameter that defines the ecryptfs_verbosity level.
> > > + */
> > > +#define VERBOSE_DUMP 9
> > > +#ifdef DEBUG
> > > +int ecryptfs_verbosity = VERBOSE_DUMP;
> > > +#else
> > > +int ecryptfs_verbosity = 1;
> > > +#endif
> > > +module_param(ecryptfs_verbosity, int, 1);
> >
> > I don't think you want a "1" here, do you?  Hint, it's not doing what
> > you think it is doing...
> Would you care to explain, providing its short, what it does? I don't
> mind admitting I don't know everything, especially when it comes to
> kernel code. If I am to RTFM, please point me to the right M. :)

include/linux/moduleparam.h:#define module_param(name, type, perm)
							     ^^^^

