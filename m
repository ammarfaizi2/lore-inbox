Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWCWOwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWCWOwI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 09:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWCWOwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 09:52:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44998 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964834AbWCWOwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 09:52:07 -0500
Date: Thu, 23 Mar 2006 14:52:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dan Aloni <da-x@monatomic.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, brking@us.ibm.com,
       dror@xiv.co.il
Subject: Re: [PATCH] scsi: properly count the number of pages in scsi_req_map_sg()
Message-ID: <20060323145203.GA13637@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dan Aloni <da-x@monatomic.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-scsi <linux-scsi@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, brking@us.ibm.com,
	dror@xiv.co.il
References: <20060321083830.GA2364@localdomain> <1142956494.4377.12.camel@mulgrave.il.steeleye.com> <20060321161912.GA32051@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321161912.GA32051@localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 06:19:12PM +0200, Dan Aloni wrote:
> These scatterlists can be generated using the sg driver. Though I am
> actually running a customized version of the sg driver, it seems the 
> conversion from a userspace array of sg_iovec_t to scatterlist stays 
> the same and also applies to the original driver (see 
> st_map_user_pages()).

What kernel version did you reproduce this with?  Since 2.6.16 sg should
obey all request size/alingment limitations.  If not that's a bug in
scsi_execute_async and it's helpers and should be fixed there.
