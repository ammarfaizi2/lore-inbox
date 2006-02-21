Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161220AbWBUAUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161220AbWBUAUJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 19:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbWBUAUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 19:20:09 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:28289 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161220AbWBUAUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 19:20:07 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc4-mm1 kernel crash at bootup. parport trouble?
Date: Tue, 21 Feb 2006 01:20:09 +0100
User-Agent: KMail/1.9.1
Cc: efault@gmx.de, helge.hafting@aitel.hist.no, linux-kernel@vger.kernel.org,
       brlink@debian.org
References: <20060220042615.5af1bddc.akpm@osdl.org> <200602210102.47371.rjw@sisk.pl> <20060220160955.3f0c4671.akpm@osdl.org>
In-Reply-To: <20060220160955.3f0c4671.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602210120.10206.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 February 2006 01:09, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > > > An unrelated problem is that USB host drivers (ohci-hcd, ehci-hcd) refuse to
> > > > suspend.  [Investigating ...]
> > > 
> > > Me too.
> > > 
> > > Try reverting reset-pci-device-state-to-unknown-after-disabled.patch.
> > 
> > Heh, that actually helps. :-)  Still I have no idea why is that so ...
> 
> Because some PCI drivers do pci_disable_device() before
> pci_set_power_state().  pci_set_power_state() sees PCI_UNKNOWN and runs
> away in terror.

Now I see that.  Thanks!
