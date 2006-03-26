Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWCZTvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWCZTvm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 14:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWCZTvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 14:51:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57995 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751504AbWCZTvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 14:51:41 -0500
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
From: Arjan van de Ven <arjan@infradead.org>
Reply-To: arjan@infradead.org
To: Bodo Eggert <7eggert@gmx.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0603262108500.13001@be1.lrz>
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz>
Content-Type: text/plain
Date: Sun, 26 Mar 2006 21:51:38 +0200
Message-Id: <1143402698.3055.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-26 at 21:28 +0200, Bodo Eggert wrote:
> Having a SCSI ID is a generic SCSI property, therefore reading it should 
> not be restricted to sg. The SCSI_IOCTL_GET_IDLUN from scsi is limited 
> below the kernel data types, so it isn't an adequate replacement.
> 
> This patch moves SG_GET_SCSI_ID from sg to scsi while renaming it to
> SCSI_IOCTL_GET_PCI. Additionally, I renamed struct sg_scsi_id to struct
> scsi_ioctl_id, since it is no longer restricted to sg. The corresponding 
> typedef will be gone.


To be honest, I think this is the wrong direction; this ioctl seems to
be a bad idea (it exposes the SPI parameters... while SPI is only one of
many nowadays). Expanding the use of such a thing... please no.

