Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbRFBV50>; Sat, 2 Jun 2001 17:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261682AbRFBV5Q>; Sat, 2 Jun 2001 17:57:16 -0400
Received: from 513.holly-springs.nc.us ([216.27.31.173]:59885 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S261679AbRFBV5E>; Sat, 2 Jun 2001 17:57:04 -0400
Subject: keyboard hook?
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 02 Jun 2001 17:56:15 -0400
Message-Id: <991518977.5581.0.camel@gromit>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm beginning the process of writing a driver for the "Qoder"
keyboard-fob barcode scanner made by InterMec. It communicates with the
host computer using the PS/2 port by way of a "dock" that sits in
between the keyboard and the computer.

The dock does handshaking with the host computer, which means that it
listens for specific signals sent from the host. One of them is "turn
numlock light on," which I can do with an ioctl from userspace (as root,
anyway), but also caps lock, num lock and carriage-return scancodes.

I will have to modify the keyboard driver to capture and process data
from the barcode scanner cleanly, and without requiring root access for
the client programs.

The CueCat driver written by Pierre Coupard also modifies the keyboard
driver. It would be nice if it was possible to load modules that hook
into keyboard processing without requiring a kernel patch. And perhaps
there is, but I haven't run across it yet.

I just need to scan the keystroke stream for an attention signal
(shift,shift,shift,alt,ctrl) and then respond ("turn on numlock light")
to initiate the data transfer; then, of course, capture and format that
data and make it available via /proc, or something.

Does anyone have any suggestions before I go ugly-up the keyboard
driver?

Thanks,

--
Michael Rothwell
rothwell@holly-springs.nc.us


