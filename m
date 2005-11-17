Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161159AbVKQHS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbVKQHS7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 02:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161161AbVKQHS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 02:18:59 -0500
Received: from natfrord.rzone.de ([81.169.145.161]:35028 "EHLO
	natfrord.rzone.de") by vger.kernel.org with ESMTP id S1161159AbVKQHS6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 02:18:58 -0500
From: Stefan Rompf <stefan@loplof.de>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC] userland swsusp
Date: Thu, 17 Nov 2005 08:19:16 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200511161700.27239.stefan@loplof.de> <20051116190715.GF2193@spitz.ucw.cz>
In-Reply-To: <20051116190715.GF2193@spitz.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511170819.17046.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch 16 November 2005 20:07 schrieb Pavel Machek:

> No. Writing to file would trash the filesystem. But you can bmap the file,
> then write to the block device.

And for reading, I could used a device mapper enforced read only mount or 
filesystem code from grub.

Hmm, how about a possibility to ask the kernel for a list of free pages on a 
swap device? This way, userspace could write the image to swap as the kernel 
currently does, avoiding possible trouble with filesystems.

> Better avoid memory allocation.

And all memory allocated and mapped in advance would be part of the image. But 
this is totally acceptable for a "suspend helper".

Stefan
