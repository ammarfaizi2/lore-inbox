Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWDZXSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWDZXSU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 19:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWDZXSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 19:18:20 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:5038 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932398AbWDZXST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 19:18:19 -0400
Subject: Re: [PATCH] drivers/scsi/sd.c: fix uninitialized variable
	in	handling medium errors
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <444FFC9B.4090603@rtr.ca>
References: <200604261627.29419.lkml@rtr.ca>
	 <1146092161.12914.3.camel@mulgrave.il.steeleye.com>
	 <444FFC9B.4090603@rtr.ca>
Content-Type: text/plain
Date: Wed, 26 Apr 2006 18:18:16 -0500
Message-Id: <1146093496.12914.11.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 19:04 -0400, Mark Lord wrote:
> Yes, but the difficulty there is that all of the convoluted logic
> seems to still be wanted to set a correct "block_sectors" value,
> needed as a parameter on the final call:
> 
>     scsi_io_completion(SCpnt, good_bytes, block_sectors << 9);

Erm, but that's only used for volume overflow (or other single sector
errors), which this isn't ... Actually, as far as I can tell, the whole
block_sectors calculation can be killed as well.

> >How does this work?
> ...
> 
> Looks potentially buggy (still).

Where?

James


