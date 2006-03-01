Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWCAH2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWCAH2k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 02:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbWCAH2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 02:28:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62440 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932524AbWCAH2j (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 02:28:39 -0500
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Nikita Danilov <nikita@clusterfs.com>, gregkh@suse.de,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20060301002302.GF23716@kroah.com>
References: <20060227190150.GA9121@kroah.com>
	 <17412.13937.158404.935427@gargle.gargle.HOWL>
	 <20060301002302.GF23716@kroah.com>
Content-Type: text/plain
Date: Wed, 01 Mar 2006 08:27:52 +0100
Message-Id: <1141198077.3866.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 16:23 -0800, Greg KH wrote:
> On Tue, Feb 28, 2006 at 02:39:29PM +0300, Nikita Danilov wrote:
> > Greg KH writes:
> > 
> > [...]
> > 
> >  > +
> >  > +  stable/
> >  > +	This directory documents the interfaces that have determined to
> >  > +	be stable.  Userspace programs are free to use these interfaces
> >  > +	with no restrictions, and backward compatibility for them will
> >  > +	be guaranteed for at least 2 years.  Most simple interfaces
> >  > +	(like syscalls) are expected to never change and always be
> >  > +	available.
> > 
> > What about separating "stable" ("guaranteed for at least 2 years") and
> > "standard" (core unix interface is not going to change ever)?
> 
> Why?  Would that mean that the POSIX-like syscalls would only be in
> "standard"?  What else would you think would be in that category?

that sounds wrong. If you want posix behavior, use glibc. Not the kernel
directly. It's that simple. The kernel tends to follow posix mostly, to
allow glibc to do this job without too much hoops, but it's glibc that
provides the final posix API to the application. And it should be that
way.

