Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbUKSVlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbUKSVlH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbUKSVlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:41:06 -0500
Received: from sd291.sivit.org ([194.146.225.122]:59078 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261592AbUKSVjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:39:07 -0500
Date: Fri, 19 Nov 2004 22:39:42 +0100
From: Stelian Pop <stelian@popies.net>
To: Christoph Hellwig <hch@infradead.org>, mdharm-usb@one-eyed-alien.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] usb-storage should enable scsi disk in Kconfig
Message-ID: <20041119213942.GG2700@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Christoph Hellwig <hch@infradead.org>, mdharm-usb@one-eyed-alien.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20041119193350.GE2700@deep-space-9.dsnet> <20041119195736.GA8466@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119195736.GA8466@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 07:57:36PM +0000, Christoph Hellwig wrote:

> On Fri, Nov 19, 2004 at 08:33:50PM +0100, Stelian Pop wrote:
> > As $subject says, usb-storage storage should automatically enable
> > scsi disk support in Kconfig.
> > 
> > Please apply.
> 
> No, it shouldn't.  There's lots of usb storage devices that don't use
> sd, as there are lots of SPI/FC/etc.. devices.

Indeed, I should have checked more carefully. My bad.

Still, it is not obvious that one should go into a completly different
config section and manually enable sd support, and I have been bitten
by this more than one time.

Maybe we should add, just below the 'USB storage' Kconfig option another
one, let's say 'SCSI disk based USB storage support', which documentation
would talk about 'usb keys, memory stick readers, USB floppy drives etc',
which should just be a dummy option selecting  BLK_DEV_SD ?

Or perhaps we should add something along the Debian's dpkg 'suggests' rule
to Kconfig ? :)

Stelian.
-- 
Stelian Pop <stelian@popies.net>
