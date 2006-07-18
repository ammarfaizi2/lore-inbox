Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWGRNHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWGRNHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 09:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWGRNHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 09:07:23 -0400
Received: from xenotime.net ([66.160.160.81]:62882 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932093AbWGRNHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 09:07:22 -0400
Message-Id: <1153228038.10819@shark.he.net>
Date: Tue, 18 Jul 2006 06:07:18 -0700
From: "Randy Dunlap" <rdunlap@xenotime.net>
To: Arjan van de Ven <arjan@infradead.org>, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: [RFC PATCH 09/33] Add start-of-day setup hooks to subarch
X-Mailer: WebMail 1.25
X-IPAddress: 70.55.232.247
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> > plain text document attachment (i386-setup)
> > Implement the start-of-day subarchitecture setup hooks for booting on
> > Xen. Add subarch macros for determining loader type and initrd
> > location.
> 
> > diff -r a5848bce3730 arch/i386/kernel/setup.c
> > --- a/arch/i386/kernel/setup.c	Thu Jun 22 16:02:54 2006 -0400
> > +++ b/arch/i386/kernel/setup.c	Thu Jun 22 20:20:31 2006 -0400
> > @@ -458,6 +458,7 @@ static void __init print_memory_map(char
> >  	}
> >  }
> >  
> > +#ifndef HAVE_ARCH_E820_SANITIZE
> >  /*
> >   * Sanitize the BIOS e820 map.
> >   *
> > @@ -677,6 +678,7 @@ int __init copy_e820_map(struct e820entr
> >  	} while (biosmap++,--nr_map);
> >  	return 0;
> >  }
> > +#endif
> >  
> Hi,
> 
> what is this for? Isn't this 1) undocumented and 2) unclear and 3)
> ugly ? (I'm pretty sure the HAVE_ARCH_* stuff is highly deprecated for
> new things nowadays)

I've read that Linus doesn't like it (putting it mildly),
but deprecated??  Yes, there are better/other ways.

---
~Randy
