Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWHPOmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWHPOmY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 10:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWHPOmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 10:42:24 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:52448 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751185AbWHPOmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 10:42:23 -0400
Date: Wed, 16 Aug 2006 16:42:22 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Raphael Hertzog <hertzog@debian.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: How to avoid serial port buffer overruns?
Message-ID: <20060816144221.GO15015@harddisk-recovery.com>
References: <fa.AByCsBI8k71hMVzCyQVimrLiDU4@ifi.uio.no> <44E32D19.3090405@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E32D19.3090405@shaw.ca>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 08:35:05AM -0600, Robert Hancock wrote:
> Raphael Hertzog wrote:
> >(Please CC me when replying)
> >
> >Hello,
> >
> >While using Linux on low-end (semi-embedded) hardware (386 SX 40Mhz, 8Mb
> >RAM), I discovered that Linux on that machine would suffer from serial
> >port buffer overruns quite easily if I use a baudrate high enough (I start
> >loosing bytes at >19200 bauds and I would like to make it reliable up to 
> >115 kbauds). I check if overruns are happening with
> >/proc/tty/driver/serial ("oe" field).
> 
> What kind of serial port are you using? If it's an unbuffered 8250-type 
> port, it will NEVER be reliable at higher baud rates. You want a 16550 
> (or better) port.

I've run a cable modem connection at 115k2 over a 16450 UART on a
386DX40 for years. The tricks were:

- hdparm -u 1 /dev/hda
- play with IRQ priorities in such a way that the serial port UART was
  handled first (there used to be a kernel module to accomplish that in
  old debian releases)


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
