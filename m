Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265839AbUFDSEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265839AbUFDSEk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUFDSEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:04:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56543 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265839AbUFDSEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:04:31 -0400
Date: Fri, 4 Jun 2004 11:04:14 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Memory leak in visor.c and ftdi_sio.c
Message-Id: <20040604110414.4f6b407a.zaitcev@redhat.com>
In-Reply-To: <c9q8a6$hga$1@sea.gmane.org>
References: <40C08E6D.8080606@infosciences.com>
	<c9q8a6$hga$1@sea.gmane.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jun 2004 17:34:41 +0100
Ian Abbott <abbotti@mev.co.uk> wrote:

> I made the original change to ftdi_sio.c to allocate the write urbs 
> and their transfer buffers dynamically (instead of using a 
> preallocated pool) and I copied that technique from visor.c!
> 
> A related problem with the current implementation is that is easy to 
> run out of memory by running something similar to this:
> 
>   # cat /dev/zero > /dev/ttyUSB0

This begs the question why in the world you discarded the
perfectly good code and went into the trouble of programming
the dynamic allocation scheme (with the leak we just plugged).

-- Pete
