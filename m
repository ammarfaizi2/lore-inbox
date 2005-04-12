Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVDLIOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVDLIOR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 04:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVDLIOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 04:14:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44460 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262046AbVDLIOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 04:14:07 -0400
Date: Tue, 12 Apr 2005 09:14:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, Alex Aizman <itn780@yahoo.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 2/6] Linux-iSCSI High-Performance Initiator
Message-ID: <20050412081403.GA551@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Alex Aizman <itn780@yahoo.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <425B3F58.2040000@yahoo.com> <20050412053650.GF32372@kroah.com> <20050412072733.GA32354@infradead.org> <20050412074514.GA1630@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412074514.GA1630@kroah.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 12:45:14AM -0700, Greg KH wrote:
> Um, why?  We've been down this road before, and for types that cross the
> boundry, we _must_ use the __ version of the kernel types, not the
> uint32_t stuff.

That's total bullshit.  C99 types just work in both the kernel and userland,
while __u* types need to be typedefed to these exact C99 everywhere in
userland bnecause they're only provided in kernelspace.

