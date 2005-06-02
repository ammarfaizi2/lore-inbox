Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVFBX4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVFBX4U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 19:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVFBX4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 19:56:19 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:59794 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261435AbVFBX4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 19:56:06 -0400
Message-ID: <429F9C90.2000602@keyaccess.nl>
Date: Fri, 03 Jun 2005 01:56:00 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Coady <grant_lkml@dodo.com.au>
CC: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Mark Lord <lkml@rtr.ca>,
       David Brownell <dbrownell@users.sourceforge.net>
Subject: Re: External USB2 HDD affects speed hda
References: <429BA001.2030405@keyaccess.nl> <20050601081810.GA23114@elf.ucw.cz> <429DFD90.10802@keyaccess.nl> <200506011240.09540.david-b@pacbell.net> <429E3338.9000401@keyaccess.nl> <20050602135737.GO23621@csclub.uwaterloo.ca> <429F0570.1090004@keyaccess.nl> <ki1v9196ga4hbeif05unuq5f29ohg5fcnc@4ax.com>
In-Reply-To: <ki1v9196ga4hbeif05unuq5f29ohg5fcnc@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:

> On Thu, 02 Jun 2005 15:11:12 +0200, Rene Herman <rene.herman@keyaccess.nl> wrote:
> 
>>In fact, anyone who could do the same would be much welcome. Certainly 
>>with the EHCI controller on a PCI card, and even more certainly with a 
>>VIA VT6212 EHCI controller on a PCI card.
> 
> 
> Not quite what you asked, following is with 6GB laptop HDD in USB 
> enclosure on /dev/sdb, main drive is Seagate SATA /dev/sda. 
> More hardware info on http://scatter.mine.nu/test/boxen/sempro/ 
>  includes an lspci -v, mobo, CPU, HDD info
> 
> nVidia driver not loaded, box running headless to ssh terminal.
> USB optical mouse only other device plugged in
> USB drive plugged in prior to reboot both times

Okay, great, thanks...

> 2.6.11.11: after many runs, plus hardware info:
> 
> root@sempro:~# cat /sys/class/usb_host/usb1/registers
> bus pci, device 0000:00:10.4 (driver 10 Dec 2004)
> EHCI 1.00, hcd state 1
> structural params 0x00004208
> capability params 0x00006872
> status a008 Async Recl FLR
> command 010009 (park)=0 ithresh=1 period=256 RUN

David, did I understand correctly that the Async status bit should not 
be set without the Async command bit, period? Or was that just in my 
case, with everything idle/off/disconnected?

If first, then I'm happy that it's not just me ...

> 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)

... although maybe still just VIA.

> 2.6.12-rc5-mm2a third run

[ snip, no Async or Recl status bit ]

> irq normal 8184 err 0 reclaim 5387 (lost 82)

No idea about those. Not seeing lost interrupts here, even after 
generating quite some traffic.

Rene.
