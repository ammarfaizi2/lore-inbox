Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265975AbUBJTOV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUBJTOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:14:21 -0500
Received: from dynast.gaugusch.at ([195.202.144.152]:5528 "EHLO
	dynast.gaugusch.at") by vger.kernel.org with ESMTP id S265975AbUBJTOP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:14:15 -0500
Date: Tue, 10 Feb 2004 20:13:47 +0100 (CET)
From: Markus Gaugusch <markus@gaugusch.at>
X-X-Sender: markus@phoenix.kerstin.at
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problem with ide-scsi and DMA
In-Reply-To: <Pine.LNX.4.58.0402092247530.3473@phoenix.kerstin.at>
Message-ID: <Pine.LNX.4.58.0402102010570.3241@phoenix.kerstin.at>
References: <Pine.LNX.4.58.0402092247530.3473@phoenix.kerstin.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 9, Markus Gaugusch <markus@gaugusch.at> wrote:

> [...] I couldn't set DMA for an ide-scsi cdrom device, kernel 2.4.24 
I found the problem:
CONFIG_IDEDMA_ONLYDISK was set for some reason (probably because I enabled 
it ;-)
The ide-scsi module disables DMA completely for the device, if this is 
set. Don't know if that should be fixed, though ...

Markus
-- 
_____________________________     /"\
Markus Gaugusch  ICQ 11374583     \ /    ASCII Ribbon Campaign
markus@gaugusch.at                 X     Against HTML Mail
                                  / \
