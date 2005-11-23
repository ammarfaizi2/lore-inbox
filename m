Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVKWOoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVKWOoA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbVKWOoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:44:00 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:48671 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750849AbVKWOn7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:43:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aqdjL0jpqvvN5pV+h0wW0NYK/4E/KKstvMb/7cJqw2I11vhMcxoRYyVmhloboJw+AO4uSmOGxCQaOuxtpZSRXlB2iO0fpnMsDN9+KdkIxo4shrAXrDSJb1TgjKikJ8nCcA4Ks8s7IPqfiHYoX6g469teCFMbQNLznhdcUvdwxSo=
Message-ID: <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com>
Date: Wed, 23 Nov 2005 09:43:58 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Christmas list for the kernel
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051123121726.GA7328@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
	 <20051123121726.GA7328@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My system has:
2 serial
1 parallel
1 floppy
1 gameport
1 joystick
2 PS/2
2 VGA
1 HPET
1 RTC

In /sys/bus/platform/devices I see this:
floppy.0
i8042
serial8250
shouldn't there be entries for all of the legacy devices?

In /dev
fd0
fd/0
fd/1
fd/2
fd/3
floppy
ttyS0
ttyS1
ttyS2
ttyS3
parport0
parport1
parport2
parport3
lp0
lp1
lp2
lp3
hpet
not sure what serio0/.1 appear as

I don't have joystick/game modules loaded.
Lot's of extra device nodes
We need to start making VGA devices

Plus I have 64 tty devices. Couldn't the tty devices be created
dynamically as they are consumed? Same for the loop and ram devices?

Because /sys isn't right the right devices don't show up in HAL.

--
Jon Smirl
jonsmirl@gmail.com
