Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbVFJQ1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVFJQ1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 12:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVFJQ1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 12:27:04 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:51162 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262600AbVFJQ0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 12:26:52 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: dtor_core@ameritech.net
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
Date: Fri, 10 Jun 2005 10:26:23 -0600
User-Agent: KMail/1.8
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Michael Tokarev <mjt@tls.msk.ru>,
       Adam Belay <ambx1@neo.rr.com>,
       matthieu castet <castet.matthieu@free.fr>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net> <200506101001.40980.bjorn.helgaas@hp.com> <d120d50005061009206d3cdb53@mail.gmail.com>
In-Reply-To: <d120d50005061009206d3cdb53@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506101026.23885.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 June 2005 10:20 am, Dmitry Torokhov wrote:
> On 6/10/05, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > On Thursday 09 June 2005 3:16 pm, Russell King wrote:
> > > The reason that 8250 first detects your ports is that they're found
> > > via the legacy method which is independent of PnP.  As you correctly
> > > sumise, when you unload 8250_pnp, it disables the device so when you
> > > re-load 8250, it's unable to detect your ports using the legacy method.
> > >
> > > But the legacy method needs to continue to exist for systems which
> > > don't have PnP enabled.
> > 
> > But shouldn't we someday move the legacy probing from 8250
> > into an 8250_platform and only do it if we don't have 8250_pnp?
> 
> Given how much pain PNP/ACPI probing of i8042 was causing to everyone
> I'd be cautious. BIOS writers are extremely creative. Maybe ia64 only
> while x86 should default to legacy probing.

Yeah, probably so :-(

(ia64 already has no legacy 8250 probing.)
