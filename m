Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWDPE2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWDPE2A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 00:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWDPE2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 00:28:00 -0400
Received: from xenotime.net ([66.160.160.81]:64662 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751209AbWDPE2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 00:28:00 -0400
Date: Sat, 15 Apr 2006 21:30:25 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org, william.waddington@beezmo.com
Subject: Re: SATA Conflict with PATA DMA
Message-Id: <20060415213025.28c958b1.rdunlap@xenotime.net>
In-Reply-To: <200604160448.47225.s0348365@sms.ed.ac.uk>
References: <fa.m9JwGQvLBixssS4UodPQfih6Ygk@ifi.uio.no>
	<fa.foo0W8w4UdiDztK9eBiA9awyAi8@ifi.uio.no>
	<p9f2425uijetlpcq49m08cto9la898l80f@4ax.com>
	<200604160448.47225.s0348365@sms.ed.ac.uk>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Apr 2006 04:48:47 +0100 Alistair John Strachan wrote:

> On Saturday 15 April 2006 19:38, Bill Waddington wrote:
> > On Sat, 15 Apr 2006 16:42:22 UTC, in fa.linux.kernel you wrote:
> > >Esben Stien wrote:
> > >> I'm having problems enabling DMA for my PATA HD.
> > >>
> > >> hdparm -d1 /dev/hdb reports:
> > >> HDIO_SET_DMA failed: Operation not permitted
> > >>
> > >> Of course, I'm super user. Nothing is printed in dmesg.
> > >>
> > >> I'm on linux-2.6.16 and motherboard is Fujitsu Siemens D1561 with an
> > >> ICH5. I also have a SATA hd in the computer and this only happens when
> > >> the SATA hd is there. If I remove the SATA HD, then I can enable DMA
> > >> for the PATA hd.
> > >
> > >Disabled combined mode in BIOS.
> >
> > If only that was possible on my fscking T43.  *sigh*
> 
> Not sure if this is universal, but if Linux doesn't claim the PATA interface, 
> the SATA seems to drive optical drives on (presumably) the other channel 
> (ICH7 here, on a Dell laptop with a similar BIOS limitation).
> 
> Try CONFIG_IDE=n and boot with libata.atapi_enable=1 and see what happens...

make that libata.atapi_enabled=1

---
~Randy
