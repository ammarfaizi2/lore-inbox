Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268113AbUHKRF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268113AbUHKRF3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 13:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268114AbUHKRF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 13:05:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20180 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268113AbUHKRFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 13:05:20 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Wed, 11 Aug 2004 10:04:02 -0700
User-Agent: KMail/1.6.2
Cc: greg@kroah.com, Martin Mares <mj@ucw.cz>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20040806211413.77833.qmail@web14926.mail.yahoo.com>
In-Reply-To: <20040806211413.77833.qmail@web14926.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408111004.02995.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 6, 2004 2:14 pm, Jon Smirl wrote:
> Please check the code out and give it some testing. It will probably
> needs some adjustment for other platforms.

Jon, this works on my machine too.  Greg, if it looks ok can you pull it in?  
And can you add:

 * (C) Copyright 2004 Silicon Graphics, Inc.
 *       Jesse Barnes <jbarnes@sgi.com>

to pci-sysfs.c if you do?

Greg was a little worried that your comment
	/* .size is set individually for each device, sysfs copies it into dentry */
might not be correct.  If not, you can reuse the code from my 
pci-sysfs-rom-7.patch if you want, otherwise it's probably fine aside from a 
bunch of trailing whitespace in the file.  I added the following to my .emacs 
to make it obvious so that I could kill it when I saw it:
(defun linux-c-mode ()
  "C mode with Linux kernel defaults"
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq c-basic-offset 8)
  (setq indent-tabs-mode t)
  (setq show-trailing-whitespace t))

Thanks,
Jesse
