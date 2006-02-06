Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWBFDnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWBFDnU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 22:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWBFDnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 22:43:20 -0500
Received: from dialin-166-132.tor.primus.ca ([216.254.166.132]:60600 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S1750935AbWBFDnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 22:43:19 -0500
Date: Sun, 5 Feb 2006 22:43:12 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: DMA in PCI chipset -- module vs. compiled-in
Message-ID: <20060206034312.GA2962@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear experts,

Normally, my PCI chipset (ie. via82cxxx, hpt366) are compiled in, and it
correctly enables DMA of my harddisk.

But, for experiment, I tried compiling in only the "generic" options,
and moved all specific PCI chipsets as modules.  Hotplug loads the
modules, but with all 'hdparm' options turned off.  When I tried turning
on DMA, 
    $ hdparm -m 16 -c 1 -u 1 -d 1 /dev/hda
I get
    /dev/hda:
     setting 32-bit IO_support flag to 1
     setting multcount to 16
     setting unmaskirq to 1 (on)
     setting using_dma to 1 (on)
     HDIO_SET_DMA failed: Operation not permitted
     multcount    = 16 (on)
     IO_support   =  1 (32-bit)
     unmaskirq    =  1 (on)
     using_dma    =  0 (off)

Is this normal?  How do I turn on DMA, if I load my PCI chipset as
module?

-- 
William Park <opengeometry@yahoo.ca>, Toronto, Canada
ThinFlash: Linux thin-client on USB key (flash) drive
	   http://home.eol.ca/~parkw/thinflash.html
BashDiff: Super Bash shell
	  http://freshmeat.net/projects/bashdiff/
