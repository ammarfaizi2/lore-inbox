Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWBVL5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWBVL5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 06:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWBVL5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 06:57:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21713 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750725AbWBVL5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 06:57:49 -0500
Date: Wed, 22 Feb 2006 03:56:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: efault@gmx.de, helge.hafting@aitel.hist.no, linux-kernel@vger.kernel.org,
       brlink@debian.org
Subject: Re: 2.6.16-rc4-mm1 kernel crash at bootup. parport trouble?
Message-Id: <20060222035657.6d2dad1f.akpm@osdl.org>
In-Reply-To: <200602221244.33770.rjw@sisk.pl>
References: <20060220042615.5af1bddc.akpm@osdl.org>
	<20060220154025.0b547085.akpm@osdl.org>
	<200602210102.47371.rjw@sisk.pl>
	<200602221244.33770.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> > > Try reverting reset-pci-device-state-to-unknown-after-disabled.patch.
>  > 
>  > Heh, that actually helps. :-)
> 
>  Well, after reverting the reset-pci-device-state-to-unknown-after-disabled.patch
>  my usb controllers actually suspend, but they don't seem to resume properly
>  (eg. the USB mouse I am addicted to doesn't work after resume).

Ho hum.  Revert

pm-add-state-field-to-pm_message_t-to-hold-actual.patch
pm-respect-the-actual-device-power-states-in-sysfs.patch
pm-minor-updates-to-core-suspend-resume-functions.patch
pm-make-pci_choose_state-use-the-real-device.patch

Eventually we'll end up at 2.6.16-rc4 ;)
