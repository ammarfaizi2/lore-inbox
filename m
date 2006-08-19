Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751829AbWHSWIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbWHSWIp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 18:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWHSWIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 18:08:44 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:33759 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751558AbWHSWIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 18:08:44 -0400
Subject: Re: [PATCH] limit recursion when flushing shost->starved_list
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andreas Herrmann <aherrman@de.ibm.com>
Cc: Jens Axboe <axboe@suse.de>, James Bottomley <jejb@SteelEye.com>,
       Linux SCSI <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060809153116.GA14043@lion28.ibm.com>
References: <20060809153116.GA14043@lion28.ibm.com>
Content-Type: text/plain
Date: Sat, 19 Aug 2006 13:30:29 -0700
Message-Id: <1156019429.3726.18.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 17:31 +0200, Andreas Herrmann wrote:
> Attached is a patch that should limit a possible recursion that can
> lead to a stack overflow like follows:

Well, OK, initially I'll put this in scsi-misc, since I acknowledge its
a problem.   However, it is one that block queue grouping should be able
to get us out of ... and at that time, this code (and most of the
starved list handling) should exit the scsi mid-layer.

James


