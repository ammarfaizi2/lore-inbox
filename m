Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWCNRJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWCNRJA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 12:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbWCNRJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 12:09:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48348 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750943AbWCNRI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 12:08:59 -0500
Date: Tue, 14 Mar 2006 17:08:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <gregkh@suse.de>
Cc: "Moore, Eric" <Eric.Moore@lsil.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com, hch@lst.de
Subject: Re: [PATCH ] drivers/base/bus.c - export reprobe
Message-ID: <20060314170855.GA18342@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <gregkh@suse.de>, "Moore, Eric" <Eric.Moore@lsil.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	James.Bottomley@SteelEye.com, hch@lst.de
References: <F331B95B72AFFB4B87467BE1C8E9CF5F36D829@NAMAIL2.ad.lsil.com> <20060314153455.GA8071@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314153455.GA8071@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 07:34:55AM -0800, Greg KH wrote:
> Also, it looks like USB needs to call this function, (based on the
> comment)?  Care to switch that code over to have it use it too?

what comment do you think indicates that?  It's needed for raid drivers
that

  a) expose physical volumes but set the no_uld_attach flag to hide them
     from sd
  b) allow only raid volume creation/deletion so this flag may be set/cleared
     at runtime

