Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVDLH4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVDLH4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 03:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVDLH4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 03:56:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:18840 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262031AbVDLH41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 03:56:27 -0400
Date: Tue, 12 Apr 2005 00:45:14 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, Alex Aizman <itn780@yahoo.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 2/6] Linux-iSCSI High-Performance Initiator
Message-ID: <20050412074514.GA1630@kroah.com>
References: <425B3F58.2040000@yahoo.com> <20050412053650.GF32372@kroah.com> <20050412072733.GA32354@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412072733.GA32354@infradead.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 08:27:33AM +0100, Christoph Hellwig wrote:
> On Mon, Apr 11, 2005 at 10:36:51PM -0700, Greg KH wrote:
> > On Mon, Apr 11, 2005 at 08:24:08PM -0700, Alex Aizman wrote:
> > >               Common header files:
> > >               - iscsi_ifev.h (user/kernel events).
> > 
> > These structures cross the user/kernel boundry?  If so, they _must_ use
> > the __u32 and friends types, not the horrible uint32_t mess...
> 
> No, C99 are just fine.

Um, why?  We've been down this road before, and for types that cross the
boundry, we _must_ use the __ version of the kernel types, not the
uint32_t stuff.

thanks,

greg k-h
