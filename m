Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130614AbQKOUDi>; Wed, 15 Nov 2000 15:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130653AbQKOUD2>; Wed, 15 Nov 2000 15:03:28 -0500
Received: from vena.lwn.net ([206.168.112.25]:64785 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S130614AbQKOUDS>;
	Wed, 15 Nov 2000 15:03:18 -0500
Message-ID: <20001115193318.21091.qmail@eklektix.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Hard lockup using emu10k1-based sound card
From: Jonathan Corbet <corbet-lk@lwn.net>
Date: Wed, 15 Nov 2000 12:33:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just as another data point, I, too, had trouble with lockups with the
emu10k1 (with the 2.4.0-test driver and ALSA both).  I noticed that it was
sharing an interrupt with ACPI.  As soon as I rebuilt the kernel with the
ACPI Interpreter option turned off, the problem went away.

It's not the first time I've gotten burned with the "turn on some option
because I might want to mess with it someday" approach to kernel
configuration...

jon
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
