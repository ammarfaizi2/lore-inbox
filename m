Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTEGPDp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbTEGPDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:03:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9603 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263571AbTEGPDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:03:44 -0400
Date: Wed, 07 May 2003 07:07:29 -0700 (PDT)
Message-Id: <20030507.070729.35526280.davem@redhat.com>
To: jgarzik@pobox.com
Cc: hch@infradead.org, pavel@ucw.cz, arnd@arndb.de,
       linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030507151203.GC3583@gtf.org>
References: <20030507135600.A22642@infradead.org>
	<1052318339.9817.8.camel@rth.ninka.net>
	<20030507151203.GC3583@gtf.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@pobox.com>
   Date: Wed, 7 May 2003 11:12:03 -0400

   On Wed, May 07, 2003 at 07:39:00AM -0700, David S. Miller wrote:
   > On Wed, 2003-05-07 at 05:56, Christoph Hellwig wrote:
   > > Btw, if you really want to move all the 32bit ioctl compat code to the
   > > drivers a ->ioctl32 file operation might be the better choice..
   > 
   > I can't believe I never thought of that. :-)
   
   Likewise.  That's a good idea...
   
But, of course, name it compat_ioctl() not ioctl32.  The compat layer
is not only about 32-bit compatibility even though that is all that it
is used for currently.
