Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267689AbUHMXSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267689AbUHMXSj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267726AbUHMXSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:18:39 -0400
Received: from the-village.bc.nu ([81.2.110.252]:57050 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267689AbUHMXSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:18:25 -0400
Subject: Re: High CPU usage (up to server hang) under heavy I/O load
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sylvain COUTANT <sylvain.coutant@illicom.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040813140229.4F48B2FC2C@illicom.com>
References: <20040813140229.4F48B2FC2C@illicom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092435364.24960.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 23:16:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-13 at 15:01, Sylvain COUTANT wrote:
> I have a problem with one server (DELL, 1 TB RAID5 + RAID0, Bi-Xeon, 8 GB
> RAM) which, sometimes, goes mad when the I/O pressure gets too high. We use
> this server as a VMWare server and as a backup server (200 GB are dedicated
> to the backup part). We have run full hardware diags and checked every
> software that runs on the system. We have been able to reproduce the problem
> once without having launched the VMWare server (so I believe this software
> is not responsible for the problem).
> 
> We have tested kernels 2.4.22 and 2.4.26. The server is running under Debian
> Woody.

Is your raid controller 64bit capable ? If you can I'd also go to a 2.6
kernel for anything > 1Gb, and definitely > 4Gb of RAM. The differences
are astounding although if your PCI I/O hardware cant do 64bit access
your box will suck whatever kernel 8)

