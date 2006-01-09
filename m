Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWAIUJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWAIUJg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWAIUJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:09:36 -0500
Received: from server5.web4a.de ([82.149.231.244]:59030 "EHLO server5.web4a.de")
	by vger.kernel.org with ESMTP id S1751295AbWAIUJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:09:36 -0500
Date: Mon, 9 Jan 2006 21:08:10 +0100
From: Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Leonid <nouser@lpetrov.net>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
In-Reply-To: <d120d5000601090954k3e35c3c7n31d4d6796ac760bf@mail.gmail.com>
References: <d120d5000601090850k42cc1c1ft6ab4e197119cacd@mail.gmail.com>
	<Pine.LNX.4.44L0.0601091215070.7432-100000@iolanthe.rowland.org>
	<d120d5000601090954k3e35c3c7n31d4d6796ac760bf@mail.gmail.com>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.8.8; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E1Ew3JK-0000kP-00@mars.bretschneidernet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

Hi Dmitry,

> My experience is that USB legacy emulation in BIOS + ACPI works as
> long as you do not touch it and gets terribly confused if someone
> tries to actually use i8042 (like enable active multiplexing mode
> with 4 AUX ports). As soon as BIOS takes its dirty hands off i8042
> everything works fine.
> 
> The problem it seems that when usb-handoff code was moved from pci
> quirks and enabled inconditionally something happened so it stopped
> doing handoff.

This words made me think about upgrading the BIOS. My former version
that caused the problem and made me start this thread was F6 from july
2005 and the most recent version is from december 2005[1]. Using this
BIOS the former problem is gone! Jens who has go the same motherboard
had the same idea and can confirm this "success" with the newer
BIOS. That is to say that I can use the keyboard (and mouse) using the
ps/2 ports with kernel 2.6.15 and enabled "USB keyboard support" in
the BIOS. The keyboard and mouse do also work -- as expected --
conncected to the USB.

Thus, I do not know what you kernel developers should do now. You can
say to the guys who have the ps/2 problem that they should update
their BIOS. But what should they do if their motherboard supplier
has not fixed the problem or does not provide BIOS updates at all?
And what exactly was the problem?

Honestly, I do not want to reflash the BIOS of my motherboard to the
older version for later debugging of modified kernel source code
since a power blackout during flashing the BIOS could destroy my
motherboard...

Kind regards from Martin

[1]
http://tw.giga-byte.com/Motherboard/Support/BIOS/BIOS_GA-K8NF-9.htm
-- 
http://www.bretschneidernet.de        OpenPGP-key: 0x4EA52583
             (*_                    Ernest Hemingway:
 $ cd /pub/  //\      I like to listen. I have learned a great deal
 $ more beer V_/_  from listening carefully. Most people never listen.
