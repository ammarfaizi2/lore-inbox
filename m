Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUC3SWC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUC3SWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:22:02 -0500
Received: from mail.zmailer.org ([62.78.96.67]:8721 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S263802AbUC3SV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:21:58 -0500
Date: Tue, 30 Mar 2004 21:21:49 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Max file size on ext3?
Message-ID: <20040330182149.GK1653@mea-ext.zmailer.org>
References: <200403302011.52322.rjwysocki@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403302011.52322.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 08:11:51PM +0200, R. J. Wysocki wrote:
> Can you tell me, please, what the file size limit on ext3 is
> (should be, if any)?

  Same as with EXT2.

  In theory with 4k block size:
     (4096/4)^3 * 4096 = 4 000 GB = 4 TB
  (plus a bit more, but that is minor detail)

  Your application must use LFS extensions, e.g.
     open("filename", O_LARGEFILE, ..)

  and your  "ulimit -f"  must be "unlimited", otherwise
  you will encounter 2 GB limit of original ABI.

  Another limitation that may come and bite you, is
  underlying block device capabilities.  Prior to 2.6
  kernels any block device can not exceed 1 TB size.
  (Or 2 TB, depending...)

> -- 
> Rafael J. Wysocki,
> SiSK
> [tel. (+48) 605 053 693]

/Matti Aarnio
