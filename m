Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbUAZOJy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 09:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbUAZOJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 09:09:54 -0500
Received: from mid-1.inet.it ([213.92.5.18]:245 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S262838AbUAZOJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 09:09:53 -0500
Date: Mon, 26 Jan 2004 15:09:29 +0100
From: Mattia Dongili <dongili@supereva.it>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Wrong Synaptics Touchpad detection when USB mouse present
Message-ID: <20040126140929.GA1182@inferi.kami.home>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040126121749.GA1078@inferi.kami.home> <20040126130952.GA26596@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040126130952.GA26596@ucw.cz>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.1-2 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 02:09:52PM +0100, Vojtech Pavlik wrote:
> On Mon, Jan 26, 2004 at 01:17:49PM +0100, Mattia Dongili wrote:
> > Hi,
> > 
> > [Please Cc me as I'm not subscribed to the list]
> > 
> > I'm experiencing problems with a dual configuration of mice on my
> > laptop. The sympthoms are:
> > 
> > - if I boot with my Logitech USB mouse plugged in, the Synaptics
> >   Touchpad is not recognized as such but as "PS/2 Generic Mouse"
> > 
> > - if I boot without USB mouse plugged in or if I simply reload psmouse
> >   after the boot process, the Synaptics Touchpad is recognized correctly
> > 
> > So it has something to do with the order modules are loaded.
> 
> Load the USB modules first. It's your BIOS intervening. Or disable USB
> Mouse support or USB Legacy support in the BIOS.

Unfortunately I have no such options on my bios (Sony Vaio GR7/K -
PhoenixBIOS 4.0 Release 6.0 - R0208C0).

Anyway I solved this problem loading uhci_hcd + hid before
psmouse in /etc/modules

Thanks for your help
-- 
mattia
:wq!
