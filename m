Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946876AbWKKCDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946876AbWKKCDE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 21:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946877AbWKKCDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 21:03:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31185 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946876AbWKKCDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 21:03:01 -0500
Date: Fri, 10 Nov 2006 18:02:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Solomon Peachy <pizza@shaftnet.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-fbdev-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>, Christian@ogre.sisk.pl,
       Hoffmann@albercik.sisk.pl, Christian.Hoffmann@wallstreetsystems.com
Subject: Re: Fwd: [Suspend-devel] resume not working on acer ferrari 4005
 with radeonfb enabled
Message-Id: <20061110180247.39878272.akpm@osdl.org>
In-Reply-To: <1163209746.4982.203.camel@localhost.localdomain>
References: <200611110031.16173.rjw@sisk.pl>
	<1163209746.4982.203.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2006 12:49:06 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sat, 2006-11-11 at 00:31 +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > We've just got the appended report.  Could you please have a look at this?
> 
> There are many possible reasons for that. The most likely is that the
> BIOS isn't bringing the chip back on resume, causing radeonfb to
> crash when trying to access it.
> 

I assume from this:

> > Greetings,
> > Rafael
> > 
> > 
> > ----------  Forwarded Message  ----------
> > 
> > Subject: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
> > Date: Friday, 10 November 2006 20:44
> > From: "Christian Hoffmann" <Christian.Hoffmann@wallstreetsystems.com>
> > To: suspend-devel@lists.sourceforge.net
> > 
> > Hello,
> >  
> > when I have radeonfb enabled, my laptop (X700 ati mobility) doesnt resume
> > anymore. Screen stays black and nothing works anymore, no capslock light, no
    ^^^^^^^

that it's a regression, from some unknown-previous-kernel-version.

> > ctrl alt sysreq b etc. I tried all kind of things vbetool, passing
> > acpi_sleep=s3_bios,s3_mode to the kernel. Nothing seems to work.
> >  
> > You can see dmesg output and lspci -vv output here 
> >  http://christianhoffmann.de/temp/radeon.log
> >  http://christianhoffmann.de/temp/lspci.log
> >  
> > Thanks a lot for any input.
> >  
> > Chris
> >  
> > PS: I use kernel 2.18.1 + patch for radeonfb from
> > http://bugzilla.kernel.org/attachment.cgi?id=9408&action=view

That's http://www.shaftnet.org/~pizza/radeonfb-atom-2.6.18-v6a.diff.

What happens when that patch isn't applied?
