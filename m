Return-Path: <linux-kernel-owner+w=401wt.eu-S1754857AbWL1Nne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857AbWL1Nne (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 08:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754858AbWL1Nne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 08:43:34 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:20940 "EHLO
	mis011-1.exch011.intermedia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754857AbWL1Nne convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 08:43:34 -0500
X-Greylist: delayed 846 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Dec 2006 08:43:33 EST
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: open /dev/kvm: No such file or directory
Date: Thu, 28 Dec 2006 05:29:35 -0800
Message-ID: <64F9B87B6B770947A9F8391472E0321609AB0D35@ehost011-8.exch011.intermedia.net>
In-Reply-To: <b6a2187b0612280508t24e0a740nd1aabdfeb706fbec@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: open /dev/kvm: No such file or directory
Thread-Index: AccqgW7Tv0PC52EOT46EYkN9l6RcSwAAfl/w
From: "Dor Laor" <dor.laor@qumranet.com>
To: "Jeff Chua" <jeff.chua.linux@gmail.com>,
       "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Dec 2006 13:29:27.0760 (UTC) FILETIME=[32AD0D00:01C72A84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>On linux-26..20-rc2, "modprobe kvm-intel" loaded the module
>successful, but running qemu returns a error ...
>
>/usr/local/kvm/bin/qemu -hda vdisk.img -cdrom cd.iso -boot d -m 128
>open /dev/kvm: No such file or directory
>Could not initialize KVM, will disable KVM support

Are you sure the kvm_intel & kvm modules are loaded?
Maybe you're bios does not support virtualization.
Please check your dmesg.

>
>/dev/kvm does not exist.... should I create this before running qemu?
>If so, what's the parameters to "mknod"?

It's a dynamic misc device, you don't need to create it.

>
>
>Thanks,
>Jeff.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
