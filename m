Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267935AbTBLXVm>; Wed, 12 Feb 2003 18:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267936AbTBLXVm>; Wed, 12 Feb 2003 18:21:42 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:50436 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267935AbTBLXVl>; Wed, 12 Feb 2003 18:21:41 -0500
Date: Wed, 12 Feb 2003 23:31:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: rudmer@legolas.dynup.net, "Randy.Dunlap" <randy.dunlap@verizon.net>,
       Mike Anderson <andmike@us.ibm.com>, linux-kernel@vger.kernel.org,
       fischer@norbit.de, Tommy.Thorn@irisa.fr
Subject: Re: [PATCH] fix scsi/aha15*.c for 2.5.60
Message-ID: <20030212233121.A20476@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Bottomley <James.Bottomley@steeleye.com>,
	rudmer@legolas.dynup.net, "Randy.Dunlap" <randy.dunlap@verizon.net>,
	Mike Anderson <andmike@us.ibm.com>, linux-kernel@vger.kernel.org,
	fischer@norbit.de, Tommy.Thorn@irisa.fr
References: <3E49DC38.52D278C4@verizon.net> <200302122246.19225@gandalf> <1045089866.1763.3.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1045089866.1763.3.camel@mulgrave>; from James.Bottomley@steeleye.com on Wed, Feb 12, 2003 at 05:44:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 05:44:24PM -0500, James Bottomley wrote:
> > this gives these modules in /lib/modules/2.5.60/kernel/drivers/scsi/:
> > aha152x.ko  scsi_mod.ko  sg.ko
> > 
> > what am i missing??
> 
> Nothing really, the symbols need to be exported from the SCSI core. 
> I'll add them to the export list.

it should _not_ be exported.  drivers are supposed to use the
request-based interface instead.

