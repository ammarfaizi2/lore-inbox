Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWGEDVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWGEDVq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 23:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWGEDVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 23:21:46 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:21192 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932313AbWGEDVp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 23:21:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Alasdair G Kergon <agk@redhat.com>
Subject: Re: [PATCH 01/15] dm: support ioctls on mapped devices
Date: Wed, 5 Jul 2006 05:22:07 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Milan Broz <mbroz@redhat.com>
References: <20060621193121.GP4521@agk.surrey.redhat.com>
In-Reply-To: <20060621193121.GP4521@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607050522.08063.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wednesday 21 June 2006 21:31 schrieb Alasdair G Kergon:
>  static struct block_device_operations dm_blk_dops = {
>         .open = dm_blk_open,
>         .release = dm_blk_close,
> +       .ioctl = dm_blk_ioctl,
>         .getgeo = dm_blk_getgeo,
>         .owner = THIS_MODULE

I guess this also needs a ->compat_ioctl method, otherwise it won't
work for ioctl numbers that have a compat_ioctl implementation in the
low-level device driver.

	Arnd <><
