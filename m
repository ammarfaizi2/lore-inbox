Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129350AbQKGS2G>; Tue, 7 Nov 2000 13:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129369AbQKGS15>; Tue, 7 Nov 2000 13:27:57 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:52727 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129350AbQKGS1q>;
	Tue, 7 Nov 2000 13:27:46 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200011070726.eA77QfC20051@flint.arm.linux.org.uk> 
In-Reply-To: <200011070726.eA77QfC20051@flint.arm.linux.org.uk> 
To: Russell King <rmk@arm.linux.org.uk>
Cc: randy.dunlap@intel.com (Dunlap, Randy), linux-kernel@vger.kernel.org
Subject: Re: USB init order dependencies. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 Nov 2000 18:27:37 +0000
Message-ID: <14241.973621657@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rmk@arm.linux.org.uk said:
>  No.  As I said elsewhere in this thread, the USB OHCI chip is not
> accessible until other board-specific initialisation has happened.
> This is done via an initcall.  Unfortunately, moving usb_init() back
> into init/main.c will mean that USB is again initialised before any
> initcalls, which means for these boards USB will be non-functional
> without additional changes over and above just moving usb_init(). 

But OHCI init isn't called from usb_init() is it?

The proposal is only to move the single call to usb_init() back into 
init/main.c - not to move all the USB initcalls back.



--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
