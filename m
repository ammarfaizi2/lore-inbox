Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbUBHXDZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 18:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbUBHXDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 18:03:25 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:24729 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S264364AbUBHXDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 18:03:22 -0500
Date: Mon, 9 Feb 2004 00:03:14 +0100
To: linux-kernel@vger.kernel.org, vojtech@suse.cz,
       acpi-devel@lists.sourceforge.net
Subject: Re: psmouse.c, throwing 3 bytes away
Message-ID: <20040208230314.GA21937@fubini.pci.uni-heidelberg.de>
References: <20040208215935.GA13280@ucw.cz> <20040208221933.92D0B3F1B@latitude.mynet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040208221933.92D0B3F1B@latitude.mynet.no-ip.org>
User-Agent: Mutt/1.3.28i
From: Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08, 2004 at 11:19:32PM +0100, aeriksson@fastmail.fm wrote:
> 
> > 
> > > Problem still occurs :-(
> > 
> > I have good news - I've managed to reliably reproduce the bug on my
> > machine and that means I now have a good chance to find and fix it.
> > 
> 
> Another data point. I just tried switching to a non-preempt kernel as
> was suggested by someone. The problem still occurs.
> 

Hello,

on IBM Thinkpads R31 this is also easiliy to reproduce:

For 2.6. one only needs to read from /proc/apm or /proc/acpic/...
and the mouse becomes crazy and one gets the throwing 2 bytes away
messages in the log files. By fast reading in an endless loop even
input from the keyboard is ignored.

For 2.4. this only happens on reading from /proc/apm, somehow acpi is not
affected in 2.4. kernel versions.

Well, for R31's it is said that it is the bad bios, but maybe its
related? Any ideas why it doesn't happen with acpi and 2.4.? 

My knowlege of the kernel interals is quite low and pretty much limited
to the basic vfs area, so could you please give me some good advises how to
debug this?

Thanks,
	Bernd
