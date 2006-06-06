Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWFFXIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWFFXIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWFFXIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:08:15 -0400
Received: from xenotime.net ([66.160.160.81]:33192 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751323AbWFFXIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:08:15 -0400
Date: Tue, 6 Jun 2006 16:11:01 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: paulkf@microgate.com, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
Message-Id: <20060606161101.f555f19f.rdunlap@xenotime.net>
In-Reply-To: <m3zmgpc3ba.fsf@defiant.localdomain>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	<20060605230248.GE3963@redhat.com>
	<20060605184407.230bcf73.rdunlap@xenotime.net>
	<1149622813.11929.3.camel@amdx2.microgate.com>
	<m3u06yc9mr.fsf@defiant.localdomain>
	<20060606134816.363cbeca.rdunlap@xenotime.net>
	<20060606140822.c6f4ef37.rdunlap@xenotime.net>
	<m3zmgpc3ba.fsf@defiant.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2006 00:44:09 +0200 Krzysztof Halasa wrote:

> "Randy.Dunlap" <rdunlap@xenotime.net> writes:
> 
> > OK, it's still not working.  As Dave Jones reported:
> >
> >> WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/
> >>   synclink_cs.ko needs unknown symbol alloc_hdlcdev
> 
> Looks like the only patch in mm3 touching it is:
> fix-kbuild-dependencies-for-synclink-drivers.
> 
> BTW: selecting CONFIG_HDLC without selecting at least one protocol
> does nothing good (except that the thing actually builds). As I said,
> I'd rather let the user decide what it's needed.

That's the problem I think.  SYNCLINK wants access to code
in hdlc_generic when CONFIG_HDLC=m and SYNCLINK*=m
but hdlc_generic.o and hdlc.ko are not being built.

> Hmm, with 2.6.17-rc5-mm3 it builds fine here (~ up-to-date FC5, i386):

---
~Randy
