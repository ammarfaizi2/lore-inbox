Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVCaRyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVCaRyx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 12:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVCaRys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 12:54:48 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:63134 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261594AbVCaRxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 12:53:55 -0500
Subject: Re: [PATCH scsi-misc-2.6 02/13] scsi: don't turn on REQ_SPECIAL on
	sgtable allocation failure.
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050331090647.C0E52845@htj.dyndns.org>
References: <20050331090647.FEDC3964@htj.dyndns.org>
	 <20050331090647.C0E52845@htj.dyndns.org>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 11:53:45 -0600
Message-Id: <1112291625.5619.21.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 18:08 +0900, Tejun Heo wrote:
> 	Don't turn on REQ_SPECIAL on sgtable allocation failure.  This
> 	was the last place where REQ_SPECIAL is turned on for normal
> 	requests.

If you do this, you'll leak a command every time the sgtable allocation
fails.

James


