Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422652AbWBVSTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbWBVSTT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWBVSTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:19:19 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:51855 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751387AbWBVSTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:19:18 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc4-mm1 kernel crash at bootup. parport trouble?
Date: Wed, 22 Feb 2006 19:19:23 +0100
User-Agent: KMail/1.9.1
Cc: efault@gmx.de, helge.hafting@aitel.hist.no, linux-kernel@vger.kernel.org,
       brlink@debian.org
References: <20060220042615.5af1bddc.akpm@osdl.org> <200602221244.33770.rjw@sisk.pl> <20060222035657.6d2dad1f.akpm@osdl.org>
In-Reply-To: <20060222035657.6d2dad1f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602221919.24122.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 February 2006 12:56, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > > > Try reverting reset-pci-device-state-to-unknown-after-disabled.patch.
> >  > 
> >  > Heh, that actually helps. :-)
> > 
> >  Well, after reverting the reset-pci-device-state-to-unknown-after-disabled.patch
> >  my usb controllers actually suspend, but they don't seem to resume properly
> >  (eg. the USB mouse I am addicted to doesn't work after resume).
> 
> Ho hum.  Revert
> 
> pm-add-state-field-to-pm_message_t-to-hold-actual.patch
> pm-respect-the-actual-device-power-states-in-sysfs.patch
> pm-minor-updates-to-core-suspend-resume-functions.patch
> pm-make-pci_choose_state-use-the-real-device.patch

Thanks, that helped.  Everything seems to be OK now. :-)
