Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVAYP5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVAYP5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 10:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVAYP5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 10:57:05 -0500
Received: from moutng.kundenserver.de ([212.227.126.191]:47311 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261989AbVAYP4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 10:56:45 -0500
From: Elias da Silva <silva@aurigatec.de>
Organization: aurigatec Informationssysteme GmbH
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] drivers/block/scsi_ioctl.c, Video DVD playback support
Date: Tue, 25 Jan 2005 16:52:51 +0100
User-Agent: KMail/1.7.2
References: <200501220327.38236.silva@aurigatec.de> <200501251029.22646.silva@aurigatec.de> <1106656675.14787.10.camel@localhost.localdomain>
In-Reply-To: <1106656675.14787.10.camel@localhost.localdomain>
Cc: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501251652.51452.silva@aurigatec.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:71cf304d62c8802a383a5ddf42c5bd08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 January 2005 13:44, you wrote:
: On Maw, 2005-01-25 at 09:29, Elias da Silva wrote:
: > On Tuesday 25 January 2005 01:01, you wrote:
: > Yes, sometimes you have to risk broken software in favor of augmented
: > security, but so far we only have broken software.
: 
: Well let me see in 2.6.5 if you could read open the block device at all
: you could erase the drive firmware. I think we've significantly improved
: security actually.

Alan, please don't let us loose focus!

I'm talking about  the classification of the opcodes
     a. GPCMD_SEND_KEY and
     b. GPCMD_SET_STREAMING

as only "save for write" in scsi_ioctl.c:verify_command()
since kernel version 2.6.8.

The intended security improvements of this restriction can be
completed circumvented by using
	a. cdrom_ioctl (..., DVD_AUTH,...) instead of
	b. cdrom_ioctl (..., CDROM_SEND_PACKET,...)

so the result is as described:

"no security improvements at the cost of broken software".

The changes looked random to me and I would like to see
a clear concept, which would drive the necessary changes for
improved security and stability.
I'm putting my finger on some loose ends below drivers/cdrom,
drivers/ide and drivers/block.

Regards,

Elias
