Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWHaDGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWHaDGG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 23:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWHaDGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 23:06:05 -0400
Received: from cs.columbia.edu ([128.59.16.20]:3581 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S932076AbWHaDGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 23:06:02 -0400
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block
	layer [try #2]
From: Shaya Potter <spotter@cs.columbia.edu>
To: Matthew Wilcox <matthew@wil.cx>
Cc: John Stoffel <john@stoffel.org>, Greg KH <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
In-Reply-To: <20060831030134.GA4919@parisc-linux.org>
References: <20060829115138.GA32714@infradead.org>
	 <20060825142753.GK10659@infradead.org>
	 <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
	 <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com>
	 <10117.1156522985@warthog.cambridge.redhat.com>
	 <15945.1156854198@warthog.cambridge.redhat.com>
	 <20060829122501.GA7814@infradead.org> <20060829195845.GA13357@kroah.com>
	 <17652.44254.620358.974993@stoffel.org>
	 <20060831030134.GA4919@parisc-linux.org>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 23:04:56 -0400
Message-Id: <1156993496.4381.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
Content-Transfer-Encoding: 7bit
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, X-Seen-By filter1.cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 21:01 -0600, Matthew Wilcox wrote:
> On Tue, Aug 29, 2006 at 05:08:46PM -0400, John Stoffel wrote:
> > Maybe the better solution is to remove SCSI as an option, and to just
> > offer SCSI drivers and USB-STORAGE and other SCSI core using drivers
> > instead.  Then the SCSI core gets pulled in automatically.  It's not
> > like people care about the SCSI core, just the drivers which depend on
> > it.
> 
> People don't want to have to say "no" to umpteen scsi drivers.  They
> just want to say "no" to SCSI, because they know they don't have scsi.

so then that's shows a problem with the kconfig syntax.

CONFIG_SCSI should perhaps be hidden, and what's visible to the user is
CONFIG_SCSI_DRIVER

USB-STORAGE would automatically pull in CONFIG_SCSI as would
CONFIG_SCSI_DRIVER.

or perhaps I'm just talking out of my ass.

