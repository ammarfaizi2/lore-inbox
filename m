Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVIGR4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVIGR4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVIGR4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:56:41 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:34004 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932072AbVIGR4k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:56:40 -0400
Date: Wed, 7 Sep 2005 10:47:44 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [GIT PATCH] SCSI merge for 2.6.13
Message-ID: <20050907174744.GA13172@us.ibm.com>
References: <1126053452.5012.28.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126053452.5012.28.camel@mulgrave>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 07:37:32PM -0500, James Bottomley wrote:
> This should be the entire contents of the SCSI tree I've been saving.
> It also includes Jens' send SCSI requests via bios tree that he, Mike
> Christie and I have been working on.
> 
> The patch is available here:
> 
> master.kernel.org:/pub/linux/kernel/scm/jejb/scsi-for-linus-2.6.git
> 

>   o convert ch to use scsi_execute_req
>   o convert sr to scsi_execute_req
>   o convert sd to scsi_execute_req (and update the scsi_execute_req API)
>   o convert SPI transport class to scsi_execute
>   o convert the remaining mid-layer pieces to scsi_execute_req

The scsi_execute() retries argument is still not used.

How is this going to work?

For example, multiple unit attentions (power on / reset) during scanning.
We send REPORT LUN, READ CAPACITY, etc., and would not retry if we got a
unit attention.

-- Patrick Mansfield
