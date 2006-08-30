Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWH3Mt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWH3Mt2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWH3Mt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:49:28 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:57296 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750823AbWH3Mt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:49:27 -0400
Subject: Re: [PATCH 18/19] BLOCK: Make USB storage depend on SCSI rather
	than selecting it [try #6]
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: David Howells <dhowells@redhat.com>, axboe@kernel.dk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <44F54FB0.7080203@s5r6.in-berlin.de>
References: <44F4ADD7.4020604@s5r6.in-berlin.de>
	 <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
	 <20060829180631.32596.69574.stgit@warthog.cambridge.redhat.com>
	 <18771.1156926354@warthog.cambridge.redhat.com>
	 <44F54FB0.7080203@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 07:49:22 -0500
Message-Id: <1156942162.11819.1.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 10:43 +0200, Stefan Richter wrote:
> David Howells wrote:
> > Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> >> What about this?
> >> 
> >>  	depends on USB
> >> +	select BLOCK
> >>  	select SCSI
> > 
> > That means you can't disable BLOCK either unless you can figure out that you
> > need to turn off USB_STORAGE.  The config client won't tell you, you have to
> > go trawling the Kconfig files.
> 
> Not true. Both xconfig and menuconfig tell you about _both_ "depends on"
> and "select" dependencies.

Would this make more sense?

	depends on USB && BLOCK
	select SCSI

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

