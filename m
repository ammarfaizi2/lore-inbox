Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUGUPCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUGUPCw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 11:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266451AbUGUPCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 11:02:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:62671 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266423AbUGUPCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 11:02:49 -0400
Date: Wed, 21 Jul 2004 16:56:49 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackeras <paulus@samba.org>
Subject: Re: reserve legacy io regions on powermac
Message-ID: <20040721145649.GA439@suse.de>
References: <20040721091249.GA1336@suse.de> <1090421466.2002.24.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1090421466.2002.24.camel@gaston>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jul 21, Benjamin Herrenschmidt wrote:

> On Wed, 2004-07-21 at 05:12, Olaf Hering wrote:
> > Anton pointed this out.
> > 
> > ppc32 can boot one single binary on prep, chrp and pmac boards.
> > pmac has no legacy io, probing for PC style legacy hardware leads to a
> > hard crash.
> > Several patches exist to prevent serial, floppy, ps2, parport and other
> > drivers from probing these io ports.
> > I think the simplest fix for 2.6 is a request_region of the problematic
> > areas.
> > PCMCIA is still missing.
> > I found that partport_pc.c pokes at varios ports, without claiming the
> > ports first. Should this be fixed?
> > smsc_check(), winbond_check(), winbond_check2()
> 
> Note that this is still all workarounds... Nothing prevents you (and some
> people actually do that) to put a PCI card with legacy serial ports on it
> inside a pmac....

Sure, but will that use the same io ports? I dont have one to verify it.
How does it look on a pccard modem?

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
