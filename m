Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWCNQIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWCNQIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWCNQIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:08:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49557 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751026AbWCNQIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:08:34 -0500
Date: Tue, 14 Mar 2006 16:08:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <gregkh@suse.de>
Cc: "Moore, Eric" <Eric.Moore@lsil.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com, hch@lst.de
Subject: Re: [PATCH ] drivers/scsi/scsi.c - export reprobe
Message-ID: <20060314160828.GA18239@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <gregkh@suse.de>, "Moore, Eric" <Eric.Moore@lsil.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	James.Bottomley@SteelEye.com, hch@lst.de
References: <F331B95B72AFFB4B87467BE1C8E9CF5F36D82A@NAMAIL2.ad.lsil.com> <20060314153524.GB8071@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314153524.GB8071@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 07:35:24AM -0800, Greg KH wrote:
> On Mon, Mar 13, 2006 at 05:52:43PM -0700, Moore, Eric wrote:
> > Request for exporting device_reprobe - 
> > This is scsi wrapper portion.
> 
> Is this even really needed?  It's just a single pointer dereference...

We don't want SCSI LLDDs to know about implementations details like
sdev->sdev_gendev.  Of course an inline or a macro could do this aswell.

