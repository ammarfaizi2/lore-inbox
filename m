Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVLBUiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVLBUiW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 15:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVLBUiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 15:38:17 -0500
Received: from kirby.webscope.com ([204.141.84.57]:11192 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1751089AbVLBUiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 15:38:15 -0500
Message-ID: <4390B0A7.8060306@m1k.net>
Date: Fri, 02 Dec 2005 15:37:59 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: CX8800 driver and 2.6.15-RC2
References: <20051202201408.GA11046@mail.muni.cz>
In-Reply-To: <20051202201408.GA11046@mail.muni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek wrote:

>Hello,
>
>I tried cx8800 driver with Leadtek Winfast 2000XP Expert card.
>This is from dmesg:
>cx2388x v4l2 driver version 0.0.5 loaded
>ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 18 (level, low) -> IRQ 19
>CORE cx88[0]: subsystem: 107d:6611, board: Leadtek Winfast 2000XP Expert
>[card=5,autodetected]
>TV tuner 44 at 0x1fe, Radio tuner -1 at 0x1fe
>cx88[0]: Leadtek Winfast 2000XP Expert config: tuner=38, eeprom[0]=0x01
>input: cx88 IR (Leadtek Winfast 2000XP as /class/input/input2
>cx88[0]/0: found at 0000:01:05.0, rev: 5, irq: 19, latency: 64, mmio: 0xfd000000
>tuner 0-0060: All bytes are equal. It is not a TEA5767
>tuner 0-0060: chip found @ 0xc0 (cx88[0])
>tuner 0-0060: type set to 38 (Philips PAL/SECAM multi (FM1216ME MK3))
>tda9887 0-0043: chip found @ 0x86 (cx88[0])
>cx88[0]/0: registered device video0 [v4l2]
>cx88[0]/0: registered device vbi0
>cx88[0]/0: registered device radio0
>
>seems to be ok.
>
>However, using xawtv I got:
>This is xawtv-3.94, running on Linux/i686 (2.6.15-rc2-git1)
>/dev/video0 [v4l2]: ioctl VIDIOC_G_FBUF: Invalid argument
>v4l-conf had some trouble, trying to continue anyway
>ioctl: VIDIOC_G_FBUF(capability=0x0 [];flags=0x0
>[];base=(nil);fmt.width=0;fmt.height=0;fmt.pixelformat=0x00000000
>[....];fmt.field=ANY;fmt.bytesperline=0;fmt.sizeimage=0;fmt.colorspace=unknown;fmt.priv=0):
>Invalid argument
>ioctl:
>VIDIOC_TRY_FMT(type=VIDEO_OVERLAY;fmt.win.w.left=852;fmt.win.w.top=45;fmt.win.w.width=384;fmt.win.w.height=288;fmt.win.field=ANY;fmt.win.chromakey=0;fmt.win.clips=(nil);fmt.win.clipcount=0;fmt.win.bitmap=(nil)):
>Invalid argument
>ioctl:
>VIDIOC_S_FMT(type=VIDEO_OVERLAY;fmt.win.w.left=852;fmt.win.w.top=45;fmt.win.w.width=384;fmt.win.w.height=288;fmt.win.field=ANY;fmt.win.chromakey=0;fmt.win.clips=(nil);fmt.win.clipcount=0;fmt.win.bitmap=(nil)):
>Invalid argument
>ioctl: VIDIOC_OVERLAY(int=0): Invalid argument
>ioctl: VIDIOC_QBUF(index=0;type=VIDEO_CAPTURE;bytesused=0;flags=0x0
>[];field=ANY;;timecode.type=0;timecode.flags=0;timecode.frames=0;timecode.seconds=0;timecode.minutes=0;timecode.hours=0;timecode.userbits="";sequence=0;memory=MMAP):
>Bad address
>ioctl: VIDIOC_QBUF(index=0;type=VIDEO_CAPTURE;bytesused=0;flags=0x0
>[];field=ANY;;timecode.type=0;timecode.flags=0;timecode.frames=0;timecode.seconds=0;timecode.minutes=0;timecode.hours=0;timecode.userbits="";sequence=0;memory=MMAP):
>Bad address
>ioctl: VIDIOC_DQBUF(index=0;type=VIDEO_CAPTURE;bytesused=0;flags=0x0
>[];field=ANY;;timecode.type=0;timecode.flags=0;timecode.frames=0;timecode.seconds=0;timecode.minutes=0;timecode.hours=0;timecode.userbits="";sequence=0;memory=unknown):
>Invalid argument
>ioctl: VIDIOC_QBUF(index=0;type=VIDEO_CAPTURE;bytesused=0;flags=0x0
>[];field=ANY;;timecode.type=0;timecode.flags=0;timecode.frames=0;timecode.seconds=0;timecode.minutes=0;timecode.hours=0;timecode.userbits="";sequence=0;memory=MMAP):
>Bad address
>ioctl: VIDIOC_QBUF(index=0;type=VIDEO_CAPTURE;bytesused=0;flags=0x0
>[];field=ANY;;timecode.type=0;timecode.flags=0;timecode.frames=0;timecode.seconds=0;timecode.minutes=0;timecode.hours=0;timecode.userbits="";sequence=0;memory=MMAP):
>Bad address
>
>I inserted video_buf module with debug option and I got:
>kernel: vbuf: reqbufs: bufs=2, size=0x36000 [108 pages total]
>kernel: vbuf: mmap setup: 2 buffers, 221184 bytes each
>kernel: vbuf: mmap ca74c420: q=ca8fe848 ae94c000-ae982000 pgoff 00000000 bufs
>0-0
>kernel: vbuf: mmap ca74c3e0: q=ca8fe848 ae916000-ae94c000 pgoff 00000036 bufs
>1-1
>kernel: vbuf: init user [0xae94c000+0x36000 => 54 pages]
>kernel: vbuf: get_user_pages: err=-14 [0]
>kernel: vbuf: init user [0xae94c000+0x36000 => 54 pages]
>kernel: vbuf: get_user_pages: err=-14 [0]
>kernel: vbuf: munmap ca74c420 q=ca8fe848
>kernel: vbuf: munmap ca74c3e0 q=ca8fe848
>kernel: vbuf: init user [0x8476fc8+0x6c000 => 109 pages]
>kernel: vbuf: reqbufs: bufs=2, size=0xe1000 [450 pages total]
>kernel: vbuf: mmap setup: 2 buffers, 921600 bytes each
>kernel: vbuf: mmap cfdd4f80: q=cec35848 b7304000-b73e5000 pgoff 00000000 bufs
>0-0
>kernel: vbuf: init user [0xb7304000+0xe1000 => 225 pages]
>kernel: vbuf: get_user_pages: err=-14 [0]
>kernel: vbuf: munmap cfdd4f80 q=cec35848
>
>
>Is it a bug in kernel modules?
>
Close, but no cigar ;-)

It was a memory management bug.... Already fixed in -rc3 (where new bugs 
were introduced) ...

-rc4 isn't bad, but a whole slew of v4l / dvb bugfixes went in JUST 
after -rc4 release...

Can you try 2.6.15-rc4-git1 and let us know how things are?

Cheers,

Michael Krufky
