Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVCaSCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVCaSCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 13:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVCaSCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 13:02:49 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:6559 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261599AbVCaSCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 13:02:34 -0500
Subject: Re: [PATCH scsi-misc-2.6 09/13] scsi: in scsi_prep_fn(), remove
	bogus comments & clean up
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050331090647.B562915C@htj.dyndns.org>
References: <20050331090647.FEDC3964@htj.dyndns.org>
	 <20050331090647.B562915C@htj.dyndns.org>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 12:02:20 -0600
Message-Id: <1112292140.5619.26.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 18:08 +0900, Tejun Heo wrote:
> -	 * come up when there is a medium error.  We have to treat
> -	 * these two cases differently.  We differentiate by looking
> -	 * at request->cmd, as this tells us the real story.
> +	 * come up when there is a medium error.

This comment isn't wrong.  That's exactly what this piece of code:

		if (sreq->sr_magic == SCSI_REQ_MAGIC) {

is all about ... that's how it distinguishes between the two cases.

The comment is misleading --- what it actually should say is that req-
>special has different contents depending upon the two cases, so
rephrasing it to be more accurate would be helpful.

James


