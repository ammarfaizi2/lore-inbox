Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130810AbQLPXw2>; Sat, 16 Dec 2000 18:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbQLPXwS>; Sat, 16 Dec 2000 18:52:18 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:4192 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130984AbQLPXwB>; Sat, 16 Dec 2000 18:52:01 -0500
Date: Sat, 16 Dec 2000 23:21:13 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, tytso@valinux.com
Subject: Re: [patch] 2.2.18 PCI_DEVICE_ID_OXSEMI_16PCI954
Message-ID: <20001216232113.B12112@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0012152140350.3740-100000@lt.wsisiz.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0012152140350.3740-100000@lt.wsisiz.edu.pl>; from lukasz@lt.wsisiz.edu.pl on Fri, Dec 15, 2000 at 09:57:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 09:57:42PM +0100, Lukasz Trabinski wrote:

> In serial dirver from Theodore Ts'o we have:
> 
>         {       PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_OXSEMI_16PCI954,

This is for a serial port device.

> (IMHO that is correct), but in kernel 2.2.18 we have:
> (include/kernel/pci.h)
> #define PCI_DEVICE_ID_OXSEMI_16PCI954PP        0x9513
>                                      ^^

This is for a parallel port device.  They are two logically different
things, have two distinct PCI bus entries, and so have two distinct
PCI device IDs and consequently different names.

> -#define PCI_DEVICE_ID_OXSEMI_16PCI954PP        0x9513
> +#define PCI_DEVICE_ID_OXSEMI_16PCI954  0x9513

Alan, do not apply, this will break the parport code.

If the OXSEMI_16PCI954 is _missing_, it probably ought to be _added_,
but it does not have 0x9513 as its ID and so the existing name should
not be changed.

Tim.
*/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
