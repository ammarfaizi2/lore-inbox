Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUJNVSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUJNVSa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUJNVRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 17:17:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9173 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267516AbUJNVO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:14:28 -0400
Date: Thu, 14 Oct 2004 17:13:38 -0400
From: Dave Jones <davej@redhat.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: signed kernel modules?
Message-ID: <20041014211338.GF18321@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	David Howells <dhowells@redhat.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	"Rusty Russell (IBM)" <rusty@au1.ibm.com>,
	David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	Joy Latten <latten@us.ibm.com>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0410140824490.363@chaos.analogic.com> <Pine.GSO.4.61.0410141617100.21062@waterleaf.sonytel.be> <Pine.LNX.4.53.0410141022180.1018@chaos.analogic.com> <Pine.LNX.4.53.0410141131190.7061@chaos.analogic.com> <20041014155030.GD26025@redhat.com> <Pine.LNX.4.61.0410141352590.8479@chaos.analogic.com> <20041014182052.GA18321@redhat.com> <Pine.LNX.4.61.0410141422530.1765@chaos.analogic.com> <20041014184635.GD18321@redhat.com> <Pine.LNX.4.61.0410141455330.5232@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410141455330.5232@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 03:03:51PM -0400, Richard B. Johnson wrote:

 > I think you guys probably got used to it. Also, you
 > seldom build the whole thing, anymore, because the
 > dependencies are handled differently.

I build the whole thing, daily. from scratch, without
ccache, with something that isn't too far from a
make allmodconfig, on a half dozen different architectures
(with multiple builds for each sometimes - 586/686,
 various ppc flavours etc).

Our build system spits out 2.6 kernel RPMs not noticably
slower their 2.4 counterparts, which were also pretty
close to a make allmodconfig.

If the builds took _twice_ as long, I would've been
shouting from the rooftops long ago.  
The factors you mention make it sound like something is
very very wrong somewhere, but there's no clear sign why
this is affecting you so badly. Maybe you should try
profiling things and find out where the additional time
is being spent.
 
 > building stuff on 2.4.x. When I went to build stuff using
 > the new build procedure I was shocked. It was like the
 > old days with 66MHz '486s (fast) and 33MHz i386's. Of
 > course there weren't modules, then so 2hrs,30min
 > was normal. Now, with a CPU that's 80 times faster and
 > a front-side bus that's 12 time faster, and SCSI
 > disks that are 40 times faster, there just has to
 > be something wrong when a complete build of the kernel
 > takes an hour.
 
How much RAM do you have ?  And are you using the same
version of gcc for both 2.4 and 2.6 builds ?

		Dave

