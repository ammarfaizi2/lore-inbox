Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWBUN5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWBUN5v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 08:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWBUN5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 08:57:51 -0500
Received: from ns2.suse.de ([195.135.220.15]:40094 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030296AbWBUN5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 08:57:51 -0500
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] PCI legacy I/O port free driver (take2) - Add device_flags into pci_device_id
References: <43FAB283.8090206@jp.fujitsu.com>
	<43FAB375.2020007@jp.fujitsu.com>
From: Andi Kleen <ak@suse.de>
Date: 21 Feb 2006 14:57:32 +0100
In-Reply-To: <43FAB375.2020007@jp.fujitsu.com>
Message-ID: <p73irr84xwz.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> writes:

> This patch adds the device_flags field into struct pci_device_id to
> enables pci device drivers to pass per device ID flags to the
> kernel. This patch also defines the PCI_DEVICE_ID_FLAG_NOIOPOT flag of
> the device_flags field which is used to tell the kernel whether the
> driver need to use I/O port regions to handle the device.


Thanks. I actually meant to use the existing driver_data field for it,
but on second thought using a new field like you did makes sense
because we could use that to easily enable MSI and possibly other
advanced features in the future too.

Only thing I would double check is if the generation of modules.pcimap
(that is used by distribution installers to load the right drivers
automatically) still works correctly.

-Andi
