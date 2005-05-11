Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVEKDjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVEKDjq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 23:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVEKDje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 23:39:34 -0400
Received: from ozlabs.org ([203.10.76.45]:20404 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261890AbVEKDj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 23:39:27 -0400
Subject: Re: [PATCH] Re: [ANNOUNCE] hotplug-ng 002 release
From: Rusty Russell <rusty@rustcorp.com.au>
To: Erik van Konijnenburg <ekonijn@xs4all.nl>
Cc: Greg KH <gregkh@suse.de>, "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Roman Kagan <rkagan@mail.ru>
In-Reply-To: <20050511031103.C7594@banaan.localdomain>
References: <20050510094339.GC6346@wonderland.linux.it>
	 <4280AFF4.6080108@ums.usu.ru> <20050510172447.GA11263@wonderland.linux.it>
	 <20050510201355.GB3226@suse.de>
	 <20050510203156.GA14979@wonderland.linux.it>
	 <20050510205239.GA3634@suse.de>
	 <20050510210823.GB15541@wonderland.linux.it>
	 <20050510232207.A7594@banaan.localdomain>
	 <20050511015509.B7594@banaan.localdomain>
	 <1115770106.17201.21.camel@localhost.localdomain>
	 <20050511031103.C7594@banaan.localdomain>
Content-Type: text/plain
Date: Wed, 11 May 2005 13:39:13 +1000
Message-Id: <1115782753.17201.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-11 at 03:11 +0200, Erik van Konijnenburg wrote:
> Here's an alternative approach that should cover these interests:
> - add a keyword 'blacklist' to the configuration language,
>   that will be interpreted after alias expansion, but before
>   searching modules.dep.

This makes "blacklist X" equivalent to "install X /bin/true" right?  i.e
"ignore it".

> Advantages:
> - it needs a lot less code
> - distributions can decide whether blacklists work always,
>   never, or only for the kernel simply by playing with which
>   configuration file is used
> - my initramfs builder does not have to be special cased
>   to know that some install directives really are blacklist
>   directives.

Well, a module mentioned in hotplug's blacklist file would be a pretty
good candidate for exclusion from your initramfs builder.  Existing
install commands are already trouble for initramfs building, since they
can do arbitrary things...

How about I allow "--config=-" and hotplug can use the existing
blacklists and 'sed'?

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

