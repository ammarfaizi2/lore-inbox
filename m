Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285850AbRLJTDV>; Mon, 10 Dec 2001 14:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285829AbRLJTDJ>; Mon, 10 Dec 2001 14:03:09 -0500
Received: from mta8.srv.hcvlny.cv.net ([167.206.5.23]:9962 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S283223AbRLJTCv>; Mon, 10 Dec 2001 14:02:51 -0500
Date: Mon, 10 Dec 2001 14:02:50 -0500 (EST)
From: Keith Warno <krjw@optonline.net>
Subject: Re: 2.4.16: scsi "PCI error Interrupt"?!
In-Reply-To: <Pine.LNX.3.95.1011210123827.517A-100000@chaos.analogic.com>
X-X-Sender: kw@behemoth.hobitch.com
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.40.0112101339130.7387-100000@behemoth.hobitch.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-12-10 at 12:44 -0500, Richard B. Johnson uttered:

| On Mon, 10 Dec 2001, Keith Warno wrote:
| > Any ideas?  I really don't like the SCSI controller sharing an interrupt
| > with anyone but I can't seem to force it to be in its own land.
|
| If the controller is a separate board, not built onto the motherboard,
| move it to a different slot! There is only one interrupt line going
| to each PCI slot. This should move the IRQ to something else.

Yes in both cases it's a separate board.  Been here, done this, and no
joy.  This is what I meant by "I can't seem to force it to be in its own
land".

| In the same manner, if a board-mounted device is sharing an IRQ with
| some slot device, move the slot device to another slot or swap it with
| something that isn't using an interrupt.

Of course.  Although not applicable in this case.

| Also, if your BIOS has an Y/N entry for (PnP OS), say "N". This
| will force the BIOS to more-properly allocate resources. This gives
| Linux at least a "correct" set-up to start with when it configures
| the PCI interface.

Yep.  It's always set to No.  I have little faith in this Plug 'n' Pray
OS jazz.

In both boxes the SCSI controller is sharing an interrupt with an AGP
NVidia board.  Obviously I can't move the NVidia board.  Shuffling the
SCSI controller around doesn't convince it not to share an IRQ with the
NVidia board.  (I also have a PCI Linksys NIC and an SB Live on the same
interrupt.  Go figure.)

The point here is I have not seen syslog messages like

scsi0: PCI error Interrupt at seqaddr = 0x8
scsi0: Data Parity Error Detected during address or write data phase

in 2.4 kernels prior to 2.4.16.  Perhaps an error was occuring with
those kernels and just wasn't being logged.  Who knows.  I'd just like
to know what specifically is causing this message to be emitted by the
kernel.

Regards,
kw

