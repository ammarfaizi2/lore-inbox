Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWI2Is6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWI2Is6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWI2Is6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:48:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32410 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750922AbWI2Is5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:48:57 -0400
Date: Fri, 29 Sep 2006 01:48:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>,
       Patrick Mochel <mochel@infinity.powertie.org>
Subject: Re: [PATCH] Don't leak 'old_class_name' in
 drivers/base/core.c::device_rename()
Message-Id: <20060929014845.70d2b807.akpm@osdl.org>
In-Reply-To: <20060929101327.1ae1b793@gondolin.boeblingen.de.ibm.com>
References: <200609282356.01962.jesper.juhl@gmail.com>
	<20060929101327.1ae1b793@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 10:13:27 +0200
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> On Thu, 28 Sep 2006 23:56:01 +0200,
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> 
> > If kmalloc() fails to allocate space for 'old_symlink_name' in
> > drivers/base/core.c::device_rename(), then we'll leak 'old_class_name'.
> 
> driver-core-fixes-check-for-return-value-of-sysfs_create_link.patch (in
> -mm) already fixes this (amongst other things).
> 

I noticed ;)

Greg, I fixed up the rejects this caued to
driver-core-fixes-check-for-return-value-of-sysfs_create_link.patch so you
might as well hang onto this patch.  Will include Cornelia's patch in the next
patch-bombing.
