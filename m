Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUEHMI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUEHMI4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 08:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbUEHMI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 08:08:56 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:20651 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S263806AbUEHMIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 08:08:54 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6-rc3-mm2
Date: Sat, 8 May 2004 14:16:44 +0200
User-Agent: KMail/1.5
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <20040505013135.7689e38d.akpm@osdl.org> <200405081329.43017.rjwysocki@sisk.pl> <20040508044330.31981c06.akpm@osdl.org>
In-Reply-To: <20040508044330.31981c06.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405081416.44664.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 of May 2004 13:43, Andrew Morton wrote:
> "R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
> > Sute, it's like that:
> >
> >  kernel /boot/vmlinuz-2.6.6-rc3-mm2 root=/dev/sdb3 vga=792 hdc=ide-scsi
> >  console=ttyS0,115200 console=tty0
>
> hm, according to the logic in there you should have seen the console
> messages on tty0 because it was the last-specified.  That's what happens
> here, whether or not Move-saved_command_line-to-init-mainc.patch is
> applied.

Well, I've been using this very command line for months, and it worked fine 
before 2.6.6-rc3-mm1.  Anyway, according to Documentation/serial-console.txt:

"You can specify multiple console= options on the kernel command line.
_Output_ _will_ _appear_ _on_ _all_ _of_ _them_ [emphasis mine]. The last 
device will be used when you open /dev/console. So, for example:

        console=ttyS1,9600 console=tty0

defines that opening /dev/console will get you the current foreground
virtual console, and kernel messages will appear on both the VGA
console and the 2nd serial port (ttyS1 or COM2) at 9600 baud."

And that's exactly what I need.  So, the syntax etc. might have changed, but 
shouldn't it be documented accordingly, then?

