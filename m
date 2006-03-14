Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752178AbWCNQbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbWCNQbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbWCNQbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:31:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25069 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751338AbWCNQbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:31:48 -0500
Subject: Re: [PATCH ] drivers/scsi/scsi.c - export reprobe
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <gregkh@suse.de>, "Moore, Eric" <Eric.Moore@lsil.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       James.Bottomley@SteelEye.com, hch@lst.de
In-Reply-To: <20060314160828.GA18239@infradead.org>
References: <F331B95B72AFFB4B87467BE1C8E9CF5F36D82A@NAMAIL2.ad.lsil.com>
	 <20060314153524.GB8071@suse.de>  <20060314160828.GA18239@infradead.org>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 17:31:41 +0100
Message-Id: <1142353902.3027.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 16:08 +0000, Christoph Hellwig wrote:
> On Tue, Mar 14, 2006 at 07:35:24AM -0800, Greg KH wrote:
> > On Mon, Mar 13, 2006 at 05:52:43PM -0700, Moore, Eric wrote:
> > > Request for exporting device_reprobe - 
> > > This is scsi wrapper portion.
> > 
> > Is this even really needed?  It's just a single pointer dereference...
> 
> We don't want SCSI LLDDs to know about implementations details like
> sdev->sdev_gendev.  Of course an inline or a macro could do this aswell.


this looks like a good candidate for an inline yes ;)

