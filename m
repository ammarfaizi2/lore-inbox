Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbTDMDml (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 23:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbTDMDml (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 23:42:41 -0400
Received: from sith.maoz.com ([205.167.76.10]:53410 "EHLO sith.maoz.com")
	by vger.kernel.org with ESMTP id S263144AbTDMDmj (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 23:42:39 -0400
From: Jeremy Hall <jhall@maoz.com>
Message-Id: <200304130354.h3D3slbp031124@sith.maoz.com>
Subject: Re: 2.5.67-mm2
In-Reply-To: <20030412201011.0d3dfa62.akpm@digeo.com> from Andrew Morton at "Apr
 12, 2003 08:10:11 pm"
To: Andrew Morton <akpm@digeo.com>
Date: Sat, 12 Apr 2003 23:54:47 -0400 (EDT)
CC: Jeremy Hall <jhall@maoz.com>, felipe_alfaro@linuxmail.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mm1 worked.

to be clear, my append line looks like

append="gdb console=gdb pci=biosirq" and maybe some other stuff on there

to get my machine to boot in single processor mode, I have to add nosmp 
and acpi=off

if I don't add acpi=off I get apic errors on my cpus, as well as if I say 
noapic like the boot process says to, it says

amd errata #22 may be present.  in the event of instability boot with the 
noapic option

dual athlon 1900 palamino's on a tyan 2462ung

_J

In the new year, Andrew Morton wrote:
> Jeremy Hall <jhall@maoz.com> wrote:
> >
> > I dunno about that, but mm2 locks in the boot process and doesn't display 
> > anything to me through gdb even though it is supposed to.  I have gdb 
> > console=gdb but that doesn't make the messages flow.
> > 
> 
> You want "gdb console=gdb".  It changed.
> 
> What CPU type?
> 
> Try just 2.5.67 plus 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm2/broken-out/linus.patch
> 
> try disabling kgdb in config.
> 
> etcetera.
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
> 

