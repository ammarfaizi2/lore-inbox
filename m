Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWH3LxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWH3LxB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 07:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWH3LxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 07:53:01 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:27079 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750791AbWH3LxA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 07:53:00 -0400
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060829201628.GA13807@kroah.com>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com>
	 <1156857214.5613.72.camel@aeonflux.holtmann.net>
	 <20060829201628.GA13807@kroah.com>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 15:49:57 +0200
Message-Id: <1156945797.4026.81.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > > Right now, various kernel modules are being migrated over to use
> > > request_firmware in order to pull in binary firmware blobs from userland
> > > when the module is loaded. This makes sense.
> > > 
> > > However, there is right now little mechanism in place to automatically
> > > determine which binary firmware blobs must be included with a kernel in
> > > order to satisfy the prerequisites of these drivers. This affects
> > > vendors, but also regular users to a certain extent too.
> > > 
> > > The attached patch introduces MODULE_FIRMWARE as a mechanism for
> > > advertising that a particular firmware file is to be loaded - it will
> > > then show up via modinfo and could be used e.g. when packaging a kernel.
> > 
> > this patch was debated, but we never came to a final conclusion. I am
> > all for it. It is simple and can improve the current situation.
> > 
> > > Signed-off-by: Jon Masters <jcm@redhat.com>
> > 
> > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> 
> Since your tree will depend on this change, you can add it there and
> add:
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> from me to the patch.

do we consider this 2.6.18 or 2.6.19 material? For the Bluetooth
subsystem I can easily write a patch that makes use of it.

Regards

Marcel


