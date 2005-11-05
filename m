Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVKETSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVKETSh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 14:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVKETSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 14:18:37 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:8910 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932298AbVKETSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 14:18:36 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH 12/25] scsi: move SG_IO ioctl32 code to sg.c
Date: Sat, 5 Nov 2005 20:19:58 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       dgilbert@interlog.com, linux-scsi@vger.kernel.org
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162715.367344000@b551138y.boeblingen.de.ibm.com> <1131209099.3614.7.camel@mulgrave>
In-Reply-To: <1131209099.3614.7.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511052020.00751.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünnavend 05 November 2005 17:44, James Bottomley wrote:
> This is the wrong place, isn't it?  SG_IO is also in
> drivers/block/scsi_ioctl.c which isn't modular, so shouldn't this be in
> there?
> 

Yes, you're right. That patch broke compat SG_IO for the other scsi
drivers. I'll do a new one.

	Arnd <><
