Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbVAPWXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbVAPWXt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVAPWRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:17:12 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:46469 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262632AbVAPWPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:15:30 -0500
Subject: Re: permissions of /proc/tty/driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Viehmann <tv@beamnet.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050116120436.GA13906@lst.de>
References: <41E80535.1060309@beamnet.de>  <20050116120436.GA13906@lst.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105908524.12196.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 16 Jan 2005 21:11:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-16 at 12:04, Christoph Hellwig wrote:
> > (where /proc/tty/driver/serial is mentioned as leaking sensitive 
> > information), to me the contents of usbserial look innocent enough.
> > Do you have any hints on what might be a good solution?
> 
> The permissions on the directory look indeed too strict to me.  It might
> be better to just use strict permissions on /proc/tty/driver/serial
> indeed.

The file containts transmit and receive byte counts, which means you can
both measure intercharacter delay and character count. Thats a big help
to password guessers

