Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752179AbWCCIIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbWCCIIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 03:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbWCCIIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 03:08:38 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:30424 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1752179AbWCCIIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 03:08:37 -0500
From: Duncan Sands <baldrick@free.fr>
To: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: MAX_USBFS_BUFFER_SIZE
Date: Wed, 1 Mar 2006 22:59:26 +0100
User-Agent: KMail/1.9.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <200603012116.25869.rene@exactcode.de> <20060301213223.GA17270@kroah.com> <200603012242.35633.rene@exactcode.de>
In-Reply-To: <200603012242.35633.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603012259.26790.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, queing alot URBs is the recommended way to sustain the bus? Allowing
> way bigger buffers will not be realistic?

usbfs could copy the user buffer to a bunch of non-contiguous pages, and
then fire those off in an urb using the scatter-gather stuff.  [Rather than,
as now, allocating a bunch of contiguous pages using kmalloc].  That would
probably make it possible to use much much bigger user-space buffers.  Plus
the code looks rather easy to write.

Ciao,

Duncan.
