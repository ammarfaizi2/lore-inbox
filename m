Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTFCR5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 13:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbTFCR5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 13:57:05 -0400
Received: from gw.netgem.com ([195.68.2.34]:28683 "EHLO gw.dev.netgem.com")
	by vger.kernel.org with ESMTP id S261414AbTFCR5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 13:57:00 -0400
Subject: Re: [BUG] ieee1394 sbp2 driver is broken for kernel >= 2.4.21-rc2
From: Jocelyn Mayer <jma@netgem.com>
To: Ben Collins <bcollins@debian.org>
Cc: Georg Nikodym <georgn@somanetworks.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030603113636.GX10102@phunnypharm.org>
References: <1054582582.4967.48.camel@jma1.dev.netgem.com>
	 <20030602163443.2bd531fb.georgn@somanetworks.com>
	 <1054588832.4967.77.camel@jma1.dev.netgem.com>
	 <20030603113636.GX10102@phunnypharm.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054663917.4967.99.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 03 Jun 2003 20:11:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-03 at 13:36, Ben Collins wrote:
> On Mon, Jun 02, 2003 at 11:20:32PM +0200, Jocelyn Mayer wrote:
> > On Mon, 2003-06-02 at 22:34, Georg Nikodym wrote:
> > > On 02 Jun 2003 21:36:22 +0200
> > > Jocelyn Mayer <jma@netgem.com> wrote:
> > > 
> > > > ... at least for PPC targets.
> > > 
> > > As a datapoint, works fine for me with my x86 laptop:
> > 
> > Hi,
> > 
> > OK, so it should be an endianness related problem...
> > I didn't test this on a PC because I need (want ?)
> > to always use the same kernel on my Mac & my PC
> > so I can test my patches always in the same conditions.
> > It gives me a start point to investigate...
> 
> No, it's a rescan-scsi-bus.sh issue. Get the script, and execute it.
> Hotplug for 2.4.x scsi is a fantasy. Just so happens it used to work,
> but that "work" used to cause oopses.

Hi,

Thanks for your help, but I think you're wrong:

First, I never trust hotplug or other tools like this:
I do all insmod by hand, so I know all drivers have been loaded.
What is hotplug supposed to do (but wasn't in previous driver
version...) ?

The second thing I see is that it used to work,
before 2.4.21-rc2. The only difference is in the kernel driver,
so it should work with no user-space tool, as it used to.
If not, the driver is now buggy...

Regards.

-- 
Jocelyn Mayer <jma@netgem.com>

