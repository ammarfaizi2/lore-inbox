Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbVCWEQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbVCWEQS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 23:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbVCWEQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 23:16:08 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:15591 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262760AbVCWEP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 23:15:59 -0500
Subject: Re: [PATCH scsi-misc-2.6 07/08] scsi: remove bogus
	{get|put}_device() calls
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050323021335.0D9E25EE@htj.dyndns.org>
References: <20050323021335.960F95F8@htj.dyndns.org>
	 <20050323021335.0D9E25EE@htj.dyndns.org>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 22:15:55 -0600
Message-Id: <1111551355.5520.100.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 11:14 +0900, Tejun Heo wrote:
> 	So, basically, SCSI high-level object (scsi_disk) and
> 	mid-level object (scsi_device) are reference counted by users,
> 	not the requests they submit.  Reference count cannot go zero
> 	with active users and users cannot access the object once the
> 	reference count reaches zero.

Actually, no.  Unfortunately we still have some fire and forget APIs, so
the contention that we always have an open refcounted descriptor isn't
always true.

James


