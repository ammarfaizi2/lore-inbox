Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130219AbQKMD1D>; Sun, 12 Nov 2000 22:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbQKMD0x>; Sun, 12 Nov 2000 22:26:53 -0500
Received: from james.kalifornia.com ([208.179.0.2]:60270 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129222AbQKMD0n>; Sun, 12 Nov 2000 22:26:43 -0500
Message-ID: <3A0F5F6D.F8B26CDF@linux.com>
Date: Sun, 12 Nov 2000 19:26:37 -0800
From: David Ford <david@linux.com>
Reply-To: david+validemail@kalifornia.com
Organization: Talon Technology, Intl.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tytso@mit.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status/TODO page (test11-pre3)
In-Reply-To: <200011121939.eACJd9D01319@trampoline.thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tytso@mit.edu wrote:

> 6. In Progress
>
>      * The new hot plug PCI interface does not provide a method for
>        passing the correct device name to cardmgr (David Hinds, a an)

is this entry missing some text?


> 9. To Do
>
>      * Tulip hang on rmmod/crashes sometimes

This is a pretty old bug that has been worked on, can we get someone to test
a system and validate the bug?

Here's a USB addition, could go into #10 as it's pretty annoying but not a
show stopper.
++ usb-uhci and JE driver will both hang the machine on a warm boot when an
external SIIG 4port hub is plugged in and has been used in a previous boot.
The function call trace is usb_uhci->start_uhci->pci_write_config_word.
Hangs on popf near end of pci_write_config_word.


> 10. To Do But Non Showstopper
>
>      * PCMCIA serial cards using built-in PCMCIA code will crash if a
>        serial card is removed. (David Ford)

Did you/someone have a patch to try and address this?


> 11. To Check
>
>           + dito if the file position changes between the call to

+t


> Fixed
>
>      * Incredibly slow loopback tcp bug (believed fixed about 2.3.48)

Note; if I set up ESD to listen on a tcp port, connecting locally sounds
horrible.  I haven't looked to see who's fault it really is.

-d

-- ---NOTICE

-- fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
