Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQJZXFj>; Thu, 26 Oct 2000 19:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbQJZXF3>; Thu, 26 Oct 2000 19:05:29 -0400
Received: from ra.lineo.com ([207.179.37.37]:44969 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S129314AbQJZXFY>;
	Thu, 26 Oct 2000 19:05:24 -0400
Message-ID: <39F8B966.E7757A34@lineo.com>
Date: Thu, 26 Oct 2000 17:08:22 -0600
From: pierre@lineo.com
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@speakeasy.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre5 won't boot on my Athlon machine (Irongate and Viper chip 
 sets)
In-Reply-To: <39F8ADF0.5050400@speakeasy.org>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 10/26/2000
 05:05:23 PM,
	Serialize complete at 10/26/2000 05:05:23 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:

> Perhaps this is related to the PCI issues that are being debated on the list now.
> Would someone look at my bus configuration and let me know what to test or what patch to apply to get my kernel booting?

My Athlon box has a MSI A6195KMS bios. The motherboard has the IronGate and the Viper chipsets, and test10-pre5 works great on it.

One possible caveats :

- USB doesn't work too well, because of a bug in the Viper USB controller. You may want to try to disable "PnP aware OS" in the bios. You may also try to download the latest rev of the A6195KMS bios
available here :

http://www.amdzone.com/files/bios/msi/a6195kms173.zip

- Even when USB finally works, the ohci USB driver sends this kind of message all the time :

usb-ohci.c: bogus NDP=64 for OHCI usb-00:07.4
usb-ohci.c: rereads as NDP=4

but it shouldn't kill your machine. In any doubt, just disable USB.

Otherwise, let me know if you want me to send you my .config and my BIOS settings, it you think they can help you.

Take care !

--
 ______
 _____   /      /   |   /  ___/   _  /
 ____   /      /    |  /  /      /  /
 ___   /      /  /    /  __/    /  /
 __   /      /  /    /  /      /  /
 _  _____/ _/ _/   _/ _____/ ____/

                ////\
                (@ @)
------------oOOo-(_)-oOOo-------------
Pierre-Philippe Coupard
Software Engineer, Lineo, Inc.
Email : pierre@lineo.com
Phone : (801) 426-5001 x 208
--------------------------------------

A door is what a dog is perpetually on the wrong side of.
                -- Ogden Nash


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
