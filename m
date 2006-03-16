Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWCPT5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWCPT5K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWCPT5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:57:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26546 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932145AbWCPT5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:57:08 -0500
Subject: Re: [usb-storage] Re: [v4l-dvb-maintainer] 2.6.16-rc: saa7134 + u
	sb-storage = freeze
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Alan Cox <alan@redhat.com>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-usb-devel@lists.sourceforge.net,
       usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>, v4l-dvb-maintainer@linuxtv.org,
       mdharm-usb@one-eyed-alien.net
In-Reply-To: <20060315234421.GB4414@devserv.devel.redhat.com>
References: <820212CF2FD63647B52A8F64B35352B20B942298@essomaexc1.essvote.com>
	 <20060315234421.GB4414@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 16 Mar 2006 16:55:11 -0300
Message-Id: <1142538911.4666.69.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qua, 2006-03-15 às 18:44 -0500, Alan Cox escreveu:
> On Wed, Mar 15, 2006 at 03:24:40PM -0600, Ballentine, Casey wrote:
> > I would bet we could add the vt8235 to the list of broken chipsets 
> > as well, if it's not already there.  My company has completely 
> 
> "Works for me" 8)
On overlay mode? Weird!
> 
> A lot of this is BIOS dependant and if we can isolate cases where one
> BIOS works and another doesn't an lspci -vvxxx would be helpful so we
> can look for chipset pokery
If bios can safely configure PCI2PCI data transfers, maybe we can
identify what bios do different and include at kernel. It is really bad
to have OOPS or data corruption if using some bad BIOS. IMHO, if we
can't safely have a way to tune pci2pci stuff at chipset, it is better
to include the hack and let the no_overlay parameter (or maybe instead a
quirk parameter at pci quirks.c) to allow user to force it.
> 
> 
> _______________________________________________
> v4l-dvb-maintainer mailing list
> v4l-dvb-maintainer@linuxtv.org
> http://www.linuxtv.org/cgi-bin/mailman/listinfo/v4l-dvb-maintainer
Cheers, 
Mauro.

