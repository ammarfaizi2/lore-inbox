Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbULVQfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbULVQfi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 11:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbULVQfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 11:35:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:58302 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262005AbULVQfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 11:35:30 -0500
Subject: Re: [PATCH] add legacy resources to sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, willy@debian.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <20041222160952.GB9358@kroah.com>
References: <200412211247.44883.jbarnes@engr.sgi.com>
	 <20041221214623.GB10362@kroah.com> <1103704739.28670.57.camel@gaston>
	 <20041222160952.GB9358@kroah.com>
Content-Type: text/plain
Date: Wed, 22 Dec 2004 17:34:37 +0100
Message-Id: <1103733278.31693.83.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-22 at 08:09 -0800, Greg KH wrote:

> Hm, what do you mean by "instance"?  My /sys/class/pci_bus has the
> individual pci busses:
>  $ tree /sys/class/pci_bus/
>  /sys/class/pci_bus/
>  |-- 0000:00
>  |   |-- bridge -> ../../../devices/pci0000:00
>  |   `-- cpuaffinity
>  |-- 0000:01
>  |   |-- bridge -> ../../../devices/pci0000:00/0000:00:01.0
>  |   `-- cpuaffinity
>  `-- 0000:02
>      |-- bridge -> ../../../devices/pci0000:00/0000:00:1e.0
>      `-- cpuaffinity
> 
> 
> We already have the cpuaffinity stuff in there, why not more, pci bus
> specific things?

Oh, I misread. If it's in /sys/class/pci_bus/(instance)/file it's fine,
sorry, my fault.

Ben.


