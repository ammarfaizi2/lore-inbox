Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbUAAPWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 10:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbUAAPWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 10:22:55 -0500
Received: from imf17aec.mail.bellsouth.net ([205.152.59.65]:62463 "EHLO
	imf17aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S264397AbUAAPWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 10:22:54 -0500
Subject: Re: udev and devfs - The final word
From: Rob Love <rml@ximian.com>
To: rob@landley.net
Cc: Andries Brouwer <aebr@win.tue.nl>, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <200401010634.28559.rob@landley.net>
References: <18Cz7-7Ep-7@gated-at.bofh.it>
	 <20040101001549.GA17401@win.tue.nl> <1072917113.11003.34.camel@fur>
	 <200401010634.28559.rob@landley.net>
Content-Type: text/plain
Message-Id: <1072970573.3975.3.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 01 Jan 2004 10:22:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-01 at 07:34, Rob Landley wrote:

> Fundamental problem: "Unique" depends on the other devices in the system.  You 
> can't guarantee unique by looking at one device, more or less by definition.

Of course.

> Combine that with hotplug and you have a world of pain.  Generating a number 
> from a device is just a fancy hashing function, but as soon as you have two 
> devices that generate the same number independently (when in separate 
> systems) and you plug them both into the same system: boom.

A solution would have to deal with collisions.

> Of course the EASY way to deal with collisions is to just fail the hash thingy 
> in a detectable way, and punt to some kind of udev override.  So if you yank 
> a drive from system A, throw it in system B, try to re-export it NFS, and 
> it's not going to work, it TELLS you.

No no no.  Nothing this complicated.  No punting to udev.

> Solve 90% of the problem space and have a human deal with the exceptions.  How 
> big's the unique number being exported, anyway?  (If it's 32 bits, the 
> exceptions are 1 in 4 billion.  It may never be seen in the wild...)

Device numbers are 64-bit now.

	Rob Love


