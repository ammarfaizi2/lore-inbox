Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUADJow (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 04:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265147AbUADJow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 04:44:52 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:57501
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261879AbUADJou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 04:44:50 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Date: Sun, 4 Jan 2004 03:43:57 -0600
User-Agent: KMail/1.5.4
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
References: <18Cz7-7Ep-7@gated-at.bofh.it> <200401020126.44234.rob@landley.net> <20040104085759.GC27612@kroah.com>
In-Reply-To: <20040104085759.GC27612@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401040343.57234.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 January 2004 02:57, Greg KH wrote:
> On Fri, Jan 02, 2004 at 01:26:44AM -0600, Rob Landley wrote:
> > > Moral: keep the identifier creation framework flexible enough so that
> > > you can chose device-specific means to produce useful identifiers.
> > > (And, use long identifiers, as they're less likely to be duplicated in
> > > general.)
> >
> > Seems to be what udev is for.  When we do go to random major and minor
> > numbers, maybe it would be useful to let udev request specific ones? 
> > (Just a thought...)
>
> Let udev request specific what?  Major/minor numbers?  Huh?  I think you
> are very confused here...

Currently, NFS exports are using device major/minor as part of the identifier 
for an exported direcory, and device numbers are going to be dynamically 
allocated in 2.7 to support hotplug, so i was wondering if there was a need 
to have some way for root to go "I know this device hotplugged in at major 3 
minor 99, but if major 53 minor 12 is free, could you change it to that?")  A 
bit like dup2, only for devices.

The discussion has moved on since then, and now it seems pretty clear that NFS 
is going to be expected to use something OTHER than device numbers, and Linus 
wants a clean break with device nodes being cookies.  Better solution all 
around, really...

But the original question did make sense.  (The answer was "no", but that's 
often the sign of a good question. :)

> thanks,
>
> greg k-h

Rob

