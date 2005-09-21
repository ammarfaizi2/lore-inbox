Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVIUQ3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVIUQ3M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVIUQ3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:29:12 -0400
Received: from odin2.bull.net ([192.90.70.84]:36344 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1751129AbVIUQ3K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:29:10 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: RT bug with 2.6.13-rt4 and 3c905c tornado
Date: Wed, 21 Sep 2005 18:32:56 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200509201046.17818.Serge.Noiraud@bull.net> <20050920085532.GA19807@elte.hu>
In-Reply-To: <20050920085532.GA19807@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509211832.56948.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mardi 20 Septembre 2005 10:55, Ingo Molnar wrote/a écrit :
> * Serge Noiraud <serge.noiraud@bull.net> wrote:
> > Hi
> >
> > 	This driver works perfectly if you insert the physical card on a
> > PCI slot. If you insert this same card on a PCI-X slot, we got the
> > following problem : When you type "modprobe 3c59x", the system freeze.
...
>
> use serial logging and the NMI watchdog to debug hard lockups (see the
> info below). Use CONFIG_DETECT_SOFTLOCKUP=y to detect soft lockups.
> Generally the use of debugging options can help as well. Here's a 'full'
> debugging kernel:
>
I have another big problem with debugging :

I have :
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y

If the following config option is set, I can't get traces. If I unset it, I 
can't get mouse or keyboard. Do you have a work around or a patch for this ?

# CONFIG_SERIO_I8042 is not set => the trace stop and keyboard works.
CONFIG_SERIO_I8042=y => the trace is ok but no keyboard and mouse.

If the system is loaded and you can type something, an echo x >/dev/ttyS0 
fixes the problem. You can have new traces. The problem is still between the 
i8042 loading module and the system ok to works : If you have a module 
loading problem or something else, you can't get trace.
