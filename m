Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbTEGXod (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbTEGXmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:42:40 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:43735 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S264339AbTEGXl5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:41:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Date: Thu, 8 May 2003 01:50:10 +0200
User-Agent: KMail/1.5.1
Cc: pavel@ucw.cz, hch@infradead.org, linux-kernel@vger.kernel.org
References: <20030507152856.GF412@elf.ucw.cz> <200305072113.07004.arnd@arndb.de> <20030507.111245.25138161.davem@redhat.com>
In-Reply-To: <20030507.111245.25138161.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="euc-jp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305080150.10697.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 May 2003 20:12, David S. Miller wrote:
>    From: Arnd Bergmann <arnd@arndb.de>
>    Date: Wed, 7 May 2003 21:13:07 +0200
>
>    Btw: is there any bit in the ioctl number definition that can
>    be (ab)used for compat_ioctl?
>
> Unfortunately no.  All the bits are used in order to allow
> the size field of the encoding to be as large as possible.

I checked the numbers that are in arch/sparc64/kernel/ioctl32.o
and found none that uses more than 9 bits for the size field,
while every architecture has at least 13 bits space. There may
of course be other ioctls that can not live with 12 bit size
fields and it's probably a bad idea to require special-casing
these in the compat code.

	Arnd <><
