Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311701AbSDXKrJ>; Wed, 24 Apr 2002 06:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311710AbSDXKrI>; Wed, 24 Apr 2002 06:47:08 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:42071 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S311701AbSDXKrI>;
	Wed, 24 Apr 2002 06:47:08 -0400
Date: Wed, 24 Apr 2002 11:46:22 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.name>
X-X-Sender: <tigran@einstein.homenet>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [REPOST][BUG] RAMFS broken in 2.4.19-pre7(-ac2)?
In-Reply-To: <Pine.LNX.4.44.0204241224280.8608-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0204241142470.1644-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You are mistaking the concept of filesystem and a block device type. You
are trying to use the ramdisk block devices but are talking about
filesystems.

As for the reason why you couldn't use the ramdisk (/dev/ram* devices) it
is due to missing support for them in your kernel configuration:

On Wed, 24 Apr 2002, Roy Sigurd Karlsbakk wrote:
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_BLK_DEV_INITRD is not set

enable CONFIG_BLK_DEV_RAM and /dev/ram* will become useable. If you also
use initrd then enable CONFIG_BLK_DEV_INITRD as well.

Regards
Tigran

