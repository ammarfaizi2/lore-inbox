Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbUDAVuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbUDAVrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:47:55 -0500
Received: from aun.it.uu.se ([130.238.12.36]:53474 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263304AbUDAVq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:46:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16492.36299.278716.247546@alkaid.it.uu.se>
Date: Thu, 1 Apr 2004 23:46:51 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm2
In-Reply-To: <20040401113043.17fe8279.akpm@osdl.org>
References: <20040323232511.1346842a.akpm@osdl.org>
	<16492.7681.332798.230663@alkaid.it.uu.se>
	<20040401113043.17fe8279.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Mikael Pettersson <mikpe@csd.uu.se> wrote:
 > >
 > > On 23 Mar 2004, Andrew Morton wrote:
 > >  > Changes since 2.6.5-rc2-mm1:
 > > ...
 > >  > -nmi_watchdog-local-apic-fix.patch
 > >  > -nmi-1-hz-2.patch
 > >  > 
 > >  >  I think these were causing kgdb to malfunction.
 > > 
 > > Any concrete evidence about this? I fail to see how
 > > the updated nmi-1-hz patch I wrote could affect kgdb
 > > in a way that wouldn't also happen on UP w/o the patch.
 > > 
 > > IOW, I'm more suspicious about the other patch to
 > > signal LAPIC NMIs on both threads on HT P4.
 > 
 > Which patch is that?

I belive nmi-1-hz-2.patch is Ok. It only changes NMI HZ.
nmi_watchdog-local-apic-fix.patch is a more likely suspect
since it actually changes NMI behaviour.

 > I'll bring the patches back, let them bake for a while.

Please try with just the nmi-1-hz-2.patch for now.

 > Could you take a look at the kgdb stub's MNI usage, see if you can spot any
 > nasty interactions?

I can have a go at it this weekend.

/Mikael
