Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVCWEPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVCWEPh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 23:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbVCWEPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 23:15:37 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:14055 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262632AbVCWEPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 23:15:31 -0500
Subject: Re: [PATCH scsi-misc-2.6 04/08] scsi: remove meaningless volatile
	qualifiers from structure definitions
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050323021335.2655518E@htj.dyndns.org>
References: <20050323021335.960F95F8@htj.dyndns.org>
	 <20050323021335.2655518E@htj.dyndns.org>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 22:15:27 -0600
Message-Id: <1111551327.5520.99.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 11:14 +0900, Tejun Heo wrote:
> 	scsi_device->device_busy, Scsi_Host->host_busy and
> 	->host_failed have volatile qualifiers, but the qualifiers
> 	don't serve any purpose.  Kill them.  While at it, protect
> 	->host_failed update in scsi_error for consistency and clarity.

Well ... the data here is volatile so what you're advocating is a move
away from a volatile variable model to a protected variable one ... did
you audit all users of both of these to make sure we have protection on
all of them?  It looks like the sata strategy handlers would still rely
on the volatile data.

James


