Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbUJ0CCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbUJ0CCn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbUJ0CCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:02:43 -0400
Received: from fmr12.intel.com ([134.134.136.15]:60035 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S261532AbUJ0CCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:02:40 -0400
Subject: Re: [ACPI] [Proposal]Another way to save/restore PCI config space
	for suspend/resume
From: Li Shaohua <shaohua.li@intel.com>
To: Hiroshi 2 Itoh <HIROIT@jp.ibm.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>, greg@kroah.com,
       Len Brown <len.brown@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <OF7E38C2D0.FC23B846-ON49256F3A.000672D1-49256F3A.0007BB88@jp.ibm.com>
References: <OF7E38C2D0.FC23B846-ON49256F3A.000672D1-49256F3A.0007BB88@jp.ibm.com>
Content-Type: text/plain
Message-Id: <1098842129.12477.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Oct 2004 09:55:30 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 09:32, Hiroshi 2 Itoh wrote:
> 
> 
> Hi,
> 
> acpi-devel-admin@lists.sourceforge.net wrote on 2004/10/26 13:50:57:
> 
> > Hi,
> > We suffer from PCI config space issue for a long time, which causes many
> > system can't correctly resume. Current Linux mechanism isn't sufficient.
> > Here is a another idea:
> > Record all PCI writes in Linux kernel, and redo all the write after
> > resume in order. The idea assumes Firmware will restore all PCI config
> > space to the boot time state, which is true at least for IA32.
> >
> 
> I think a basic problem of current Linux device model is that there is no
> effective message path from sibling devices to their root device.
> Although the message direction from a root device to sibling devices is
> natural from the viewpoint of device enumeration, the direction from
> sibling devices to a root device is required for effective arbitration for
> device configuration and power management.
> 
> The Windows driver model uses the direction from sibling drivers to a root
> bus driver mainly, i.e. sibling drivers are layered on a root bus driver.
> While we need a kind of callback mechanism from PCI (sibling) devices to
> PCI bus (root) device instead because their normal call interface is from a
> root device to sibling devices.
Hiro-san,
I don't really understand why this is related with suspend/resume. Could
you please explain it more clearly?

Thanks,
Shaohua


