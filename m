Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262958AbVCWXwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbVCWXwQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVCWXwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:52:15 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:46534 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262957AbVCWXuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:50:13 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.12-rc1-mm1: resume regression [update] (was: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389)
Date: Thu, 24 Mar 2005 00:49:25 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Len Brown <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>,
       Shaohua Li <shaohua.li@intel.com>
References: <20050322013535.GA1421@elf.ucw.cz> <200503232329.50461.rjw@sisk.pl> <20050323223918.GL30704@elf.ucw.cz>
In-Reply-To: <20050323223918.GL30704@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503240049.25695.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 23 of March 2005 23:39, Pavel Machek wrote:
> Hi!
> 
> > > > > Will this do it for the moment?
> > > > 
> > > > Its certainly better.
> > > 
> > > With the Len's patch applied I have to unload the modules:
> > > 
> > > ohci_hcd
> > > ehci_hcd
> > > yenta_socket
> > > 
> > > before suspend as each of them hangs the box solid during either
> > > suspend or resume.  Moreover, when I tried to load the ehci_hcd
> > > module back after resume, it hanged the box solid too.
> > 
> > This behavior is apparently caused by the call to pci_write_config_word() with
> > pmcsr = 0 in drivers/pci/pci.c:pci_set_power_state().
> > 
> > Well, I don't think I can do anything more about it myself. :-)
> 
> Can you just revert those two patches from Len, and see what happens?

Reverting them doesn't change anything, so there's something else that
breaks things, apparently.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
