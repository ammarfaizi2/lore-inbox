Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVKEQpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVKEQpH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVKEQpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:45:06 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:29134 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932151AbVKEQpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:45:03 -0500
Subject: Re: [PATCH 12/25] scsi: move SG_IO ioctl32 code to sg.c
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       dgilbert@interlog.com, linux-scsi@vger.kernel.org
In-Reply-To: <20051105162715.367344000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
	 <20051105162715.367344000@b551138y.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Sat, 05 Nov 2005 10:44:59 -0600
Message-Id: <1131209099.3614.7.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-05 at 17:27 +0100, Arnd Bergmann wrote:
> plain text document attachment (sg-ioctl.diff)
> The sg driver already has a compat_ioctl function, so the
> conversion handler for SG_IO can easily be moved in there
> as well. It still uses compat_alloc_user_space, so it can
> probably be simplified by using merging the conversion
> handler with the native method.

This is the wrong place, isn't it?  SG_IO is also in
drivers/block/scsi_ioctl.c which isn't modular, so shouldn't this be in
there?

James


