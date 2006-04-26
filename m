Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWDZAZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWDZAZw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 20:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWDZAZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 20:25:52 -0400
Received: from mx1.suse.de ([195.135.220.2]:28620 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932305AbWDZAZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 20:25:51 -0400
Date: Tue, 25 Apr 2006 17:24:31 -0700
From: Greg KH <greg@kroah.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [patch 2/2] kref: kref debugging config option
Message-ID: <20060426002431.GA24343@kroah.com>
References: <20060425082137.028875000@localhost.localdomain> <20060425082400.335913000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425082400.335913000@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 04:21:39PM +0800, Akinobu Mita wrote:
> -	WARN_ON(atomic_read(&kref->refcount) < 1);
> -	WARN_ON(release == NULL);
> -	WARN_ON(release == (void (*)(struct kref *))kfree);

No, those two last WARN_ON() are not "debugging" checks, they are
"checks for people trying to do bad things with kref code".  I always
want them "on", as there should not be any excuse for anyone to do this.

So I don't think this patch is needed at all.

thanks,

greg k-h
