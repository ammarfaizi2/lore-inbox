Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264656AbUFDIHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264656AbUFDIHi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 04:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbUFDIHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 04:07:38 -0400
Received: from pop.gmx.de ([213.165.64.20]:15263 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264656AbUFDIHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 04:07:34 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-rc2-mm2
Date: Fri, 4 Jun 2004 10:17:40 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040603015356.709813e9.akpm@osdl.org> <200406031703.38722.dominik.karall@gmx.net> <20040603161813.32ea0b84.akpm@osdl.org>
In-Reply-To: <20040603161813.32ea0b84.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406041017.44213.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 June 2004 01:18, Andrew Morton wrote:
> Dominik Karall <dominik.karall@gmx.net> wrote:
> > On Thursday 03 June 2004 10:53, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc2
> > >/2.6 .7-rc2-mm2/
> >
> > SiS framebuffer works here. But my kernel does not boot, it stops at
> >
> > Starting hotplug subsystem:
> >    input
> >    net
> >    pci
> >      sis900: already loaded
> >      8139too: already loaded
> >      ignore pci display device on 01:00.0
> >    usb
> >
> > and right here it stops.
> >
> > Normally it looks this way:
> >
> > Starting hotplug subsystem:
> >    input
> >    net
> >    pci
> >      sis900: already loaded
> >      8139too: already loaded
> >      ignore pci display device on 01:00.0
> >    usb
> > done
>
> Can you get sysrq-T output?

As I didn't know whats that command, I googled for it and found that I must 
hit Alt+SysRq+t and then debug information should be printed out, am I right? 
But I tried that, and nothing happens. SYSCTL is enabled in the kernel 
config.
If you really need this output, I would be pleased if anybody can inform me 
how I can get it. Thanks in advance!

>
> Can you please grab
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc2/2.6
>.7-rc2-mm2/broken-out/bk-usb.patch and do
>
> 	patch -p1 -R -i ~/bk-usb.patch
>
> and retest?

I reverted the bk-usb.patch and it works now.

greets dominik
