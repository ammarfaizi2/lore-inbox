Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbTEFNcn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbTEFNcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:32:43 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6784
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263709AbTEFNcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:32:42 -0400
Subject: RE: Binary firmware in the kernel - licensing issues.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Downing, Thomas" <Thomas.Downing@ipc.com>
Cc: Simon Kelley <simon@thekelleys.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <170EBA504C3AD511A3FE00508BB89A9202085B63@exnanycmbx4.ipc.com>
References: <170EBA504C3AD511A3FE00508BB89A9202085B63@exnanycmbx4.ipc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052225199.1202.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 13:46:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-06 at 13:54, Downing, Thomas wrote:
> PS:  what would be the preferred place to load the firmware
> from, if no option giving the firmware pathname is passed to the 
> module at load time?

When a device appears the /sbin/hotplug scripts are called. They 
could either load the firmware themselves (since the usbdevfs allows
you to talk directly to the device), or could make a call to give
the firmware to the driver (eg ioctl)

