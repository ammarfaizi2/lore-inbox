Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUJRSmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUJRSmw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUJRSlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:41:25 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:41600
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S267326AbUJRShI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:37:08 -0400
Date: Mon, 18 Oct 2004 11:37:07 -0700
From: Phil Oester <kernel@linuxace.com>
To: Andi Kleen <ak@suse.de>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, bevand_m@epita.fr,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: NMI watchdog detected lockup
Message-ID: <20041018183707.GA11947@linuxace.com>
References: <4172F91D.8090109@osdl.org> <ckv123$pcs$1@sea.gmane.org> <4173F9A7.2090504@osdl.org> <20041018200017.0098710d.ak@suse.de> <41740430.30604@osdl.org> <20041018201654.58905384.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041018201654.58905384.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 08:16:54PM +0200, Andi Kleen wrote:
> On Mon, 18 Oct 2004 10:58:08 -0700
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> 
> > > Something on your system creates bogus NMI interrupts. What chipset
> > > are you using exactly?
> > > 
> > > Sometimes chipsets can be programmed to raise NMIs when an PCI bus
> > > error occurs. 
> > > 
> > > 21 is the normal state (PIT timer running, but no errors logged) 
> > > 
> > > If you have an AMD 8131 it could be in theory erratum 54, but then
> > > normally one of the error bits in reason should be set.
> > 
> > Yes, it's an AMD-8111 / 8131 / 8151 / K8-northbridge machine.
> 
> It's probably one of your IO cards. I would remove them one by one
> or possibly switch them to different slots (PCI vs PCI-X) 

Not sure if it's related, but I've noticed this with numerous 440gx
boxes on 2.6.8.1.  I get reasons 2d and 3d.  If I reboot with
nmi_watchdog=1 on these boxes, the errors go away.  This was not
a problem on 2.6.3 interestingly enough...

Phil
