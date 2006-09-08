Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWIHI1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWIHI1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 04:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWIHI1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 04:27:33 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:5293 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S1751020AbWIHI1c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 04:27:32 -0400
Date: Fri, 8 Sep 2006 10:27:18 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: re-reading the partition table on a "busy" drive
Message-ID: <20060908082718.GA30894@aepfle.de>
References: <45004707.4030703@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45004707.4030703@tls.msk.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, Michael Tokarev wrote:

> Is it possible to implement such a feature?  I mean, is it
> easy to know which *partitions* (subdevices?) of the whole
> device are currently in use, as opposed to the whole drive?

Its already there, see include/linux/blkpg.h
parted uses this interface, fdisk and others use the rereadpt ioctl.
