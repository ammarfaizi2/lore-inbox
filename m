Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWH2T7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWH2T7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 15:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWH2T7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 15:59:49 -0400
Received: from cantor2.suse.de ([195.135.220.15]:48342 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751389AbWH2T7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 15:59:48 -0400
Date: Tue, 29 Aug 2006 12:58:45 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2]
Message-ID: <20060829195845.GA13357@kroah.com>
References: <20060829115138.GA32714@infradead.org> <20060825142753.GK10659@infradead.org> <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> <10117.1156522985@warthog.cambridge.redhat.com> <15945.1156854198@warthog.cambridge.redhat.com> <20060829122501.GA7814@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829122501.GA7814@infradead.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 01:25:01PM +0100, Christoph Hellwig wrote:
> On Tue, Aug 29, 2006 at 01:23:18PM +0100, David Howells wrote:
> > Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > > Same as above.  USB_STORAGE already selects scsi so it shouldn't need
> > > to depend on block.
> > 
> > Ah, you've got it the wrong way round.
> > 
> > Because USB_STORAGE _selects_ SCSI rather than depending on it, even if SCSI
> > is disabled, USB_STORAGE can be enabled, and that turns on CONFIG_SCSI, even
> > if not all of its dependencies are available.
> > 
> > Run "make allyesconfig" and then try to turn off CONFIG_SCSI without this...
> 
> Eeek.  The easy fix is to change USB_STORAGE to depend on SCSI (*), but in
> addition to that we should probably fix Kconfig aswell to adhere to
> such constraints.

No, the reason this was switched around like this (it used to be the
other way), was that people constantly complained about not being able
to select the usb-storage driver in their configurations.

Can't seem to please everyone these days :)

thanks,

greg k-h
