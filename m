Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWEJVDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWEJVDT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWEJVDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:03:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:41449 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964854AbWEJVDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:03:18 -0400
Date: Wed, 10 May 2006 13:57:43 -0700
From: Greg KH <gregkh@suse.de>
To: Michael Buesch <mb@bu3sch.de>
Cc: Sergey Vlasov <vsu@altlinux.ru>, akpm@osdl.org,
       Deepak Saxena <dsaxena@plexity.net>, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/6] New Generic HW RNG
Message-ID: <20060510205743.GC23446@suse.de>
References: <20060507113513.418451000@pc1> <20060507113604.778384000@pc1> <20060507170320.3ce0d3e0.vsu@altlinux.ru> <200605071516.09167.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605071516.09167.mb@bu3sch.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2006 at 03:16:08PM +0200, Michael Buesch wrote:
> On Sunday 07 May 2006 15:03, you wrote:
> > > +	list_for_each_entry(rng, &rng_list, list) {
> > > +		if (strncmp(rng->name, buf, len) == 0) {
> > 
> > This will match if the passed string is just a prefix of rng->name.
> > Apparently sysfs guarantees that the buffer passed to ->store will be
> > NUL-terminated, so this should be just a strcmp().
> 
> I am not sure if it is guaranteed NUL terminated. Greg?
> But I will look into this.

Yes it will be.

thanks,

greg k-h
