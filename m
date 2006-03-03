Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752192AbWCCJNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbWCCJNY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 04:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752194AbWCCJNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 04:13:24 -0500
Received: from mail.humboldt.co.uk ([80.68.93.146]:23563 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP
	id S1752192AbWCCJNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 04:13:23 -0500
Subject: Re: Linux running on a PCI Option device?
From: Adrian Cox <adrian@humboldt.co.uk>
To: Jon Ringle <jringle@vertical.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200603021707.01190.jringle@vertical.com>
References: <43EAE4AC.6070807@snapgear.com>
	 <200602281535.21974.jringle@vertical.com>
	 <Pine.LNX.4.61.0602281556240.5128@chaos.analogic.com>
	 <200603021707.01190.jringle@vertical.com>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 09:13:07 +0000
Message-Id: <1141377188.8912.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 17:07 -0500, Jon Ringle wrote:

> As it turns out, Linux completes it's bootup before Windows bootup even 
> begins, and it seems that Linux changes the configuration of the various 
> other PCI devices that happen to be on the system as well. I need to get 
> Linux to leave the configuration of other PCI devices it finds alone. It 
> should only mess with it's own configuration. Why should Linux need to change 
> the configuration of other PCI devices when it is fulfilling the role of a 
> PCI device itself?

Have you disabled CONFIG_PCI?

CONFIG_PCI is the configuration option for a PCI host, just as
CONFIG_USB is the configuration option for a USB host. Linux contains
code for CONFIG_USB_GADGET, but what you need is the non-existent
CONFIG_PCI_GADGET.

If you're running on a PCI option device (unless using a 21555
non-transparent bridge), you need to disable CONFIG_PCI and write your
own driver for the PCI option device functionality.

-- 
Adrian Cox <adrian@humboldt.co.uk>

