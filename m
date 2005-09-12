Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbVILQD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbVILQD1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVILQD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:03:27 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:16012 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750901AbVILQD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:03:26 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: multiple independent keyboard kernel support
Date: Mon, 12 Sep 2005 10:03:11 -0600
User-Agent: KMail/1.8.1
Cc: Martin Mares <mj@ucw.cz>, Vojtech Pavlik <vojtech@suse.cz>,
       Zoltan Szecsei <zoltans@geograph.co.za>, linux-kernel@vger.kernel.org
References: <4316E5D9.8050107@geograph.co.za> <20050901144812.GA3483@atrey.karlin.mff.cuni.cz> <20050911223619.GB19403@aitel.hist.no>
In-Reply-To: <20050911223619.GB19403@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509121003.11086.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 September 2005 4:36 pm, Helge Hafting wrote:
> On Thu, Sep 01, 2005 at 04:48:12PM +0200, Martin Mares wrote:
> > Hello!
> > 
> > > Btw, Aivils Stoss created a nice way to make several X instances have
> > > separate keyboards - see the linux-console archives for the faketty
> > > driver.
> > 
> > I haven't looked recently, but when I tried that several years ago,
> > the biggest problem was to make two simultaneously running X servers
> > not switch off each other's video card I/O ports off :)
> > 
> Look again.  X config files now have "IsolateDevice" and "BusID"
> to deal with this.  At least iff you get your X from ubuntu or
> debian testing . . .

Yes, but I think IsolateDevice still isn't quite enough if you
have VGA devices behind PCI-PCI bridges.  In other words, devices
behind bridges still get disabled, even with IsolateDevice.

And the ideal situation would be if IsolateDevice could be the
*default*, but the X bugzilla[1] says some devices have problems
with that.

[1] https://bugs.freedesktop.org/show_bug.cgi?id=2216
