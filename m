Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262741AbTC0B1z>; Wed, 26 Mar 2003 20:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262742AbTC0B1z>; Wed, 26 Mar 2003 20:27:55 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:39359 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S262741AbTC0B1x>; Wed, 26 Mar 2003 20:27:53 -0500
Message-Id: <5.1.0.14.2.20030326173416.0efdc710@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 26 Mar 2003 17:38:57 -0800
To: Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Preferred way to load non-free firmware
In-Reply-To: <Pine.LNX.4.50.0303252007420.6656-100000@marabou.research.a
 tt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:32 PM 3/25/2003, Pavel Roskin wrote:
>Hello!
>
>I'm writing a Linux device driver for a device that requires non-free
>firmware in order to function.  The firmware can be easily extracted from
>the Windows driver for that device.  The device is a PCMCIA wireless card.
>
>The firmware is about 60k in size, and it mostly consists of executable
>code for ARM processor.  Reimplementing it is out of question for me.
>
>What would be the best approach to handle this situation:
>
>1) Register a file on procfs and use "cat" to load the firmware into the
>kernel.
>
>2) Register a device for the same purpose.
>
>3) Register a device, but use ioctl().
>
>4) Open a network socket and use ioctl() on it (like ifconfig does).
>
>5) Use one of the the above ways to send the filename to the module and
>let the module load the firmware from file using do_generic_file_read().
>
>6) Provide a script to wrap firmware into a module and load it using
>modprobe.
>
>7) Encode the firmware into a header file, add it to the driver and
>pretend that the copyright issue doesn't exist (like it's done in the
>Keyspan USB driver).
>
>Better ideas?

8) Have the driver call external user-space firmware loader that uses
either iopl/outb/inb or mmap(/dev/mem) and loads firmware directly.

Max





