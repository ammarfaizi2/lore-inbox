Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbWEXFEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWEXFEl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 01:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWEXFEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 01:04:41 -0400
Received: from smtp.enter.net ([216.193.128.24]:21263 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932584AbWEXFEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 01:04:40 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Wed, 24 May 2006 01:04:29 +0000
User-Agent: KMail/1.8.1
Cc: "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, "Dave Airlie" <airlied@linux.ie>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605240042.46288.dhazelton@enter.net> <9e4733910605232157w3afe1ab6vd5aa35fad27562e1@mail.gmail.com>
In-Reply-To: <9e4733910605232157w3afe1ab6vd5aa35fad27562e1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605240104.30534.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 May 2006 04:57, Jon Smirl wrote:
> On 5/23/06, D. Hazelton <dhazelton@enter.net> wrote:
> > I had planned on actually exporting the full, probed capabilities of the
> > devices to userspace via sysfs, though I don't know if there is a good
> > way to export full DDC or EDID information. Perhaps that should go
> > somewhere in /proc?  (I know, the kernel is moving away from information
> > in /proc but the sysfs "single setting per file" would mean a lot of
> > files to contain all the potential information)
>
> Load an fbdev driver and look in sysfs. fbdev already has the ability
> to list the valid modes via the 'modes' parameter. Copy one of those
> strings into 'mode' and your more will be set.

Okay. I was under the impression that it wasn't good to have more than one bit 
of information per file in sysfs.

> > And as you note, licensing is an issue. However, as the kernel is GPL I
> > might use DRM as an information source and write that code over again to
> > sidestep any licensing issues. (I really don't want to piss off the MIT
> > or BSD people)
>
> But it is very hard to merge DRM and fbdev without touching the fbdev
> code and getting things mixed up.  Plus there is no guarantee that BSD
> will even use your code if you keep the license clean. Other OS's
> don't necessarily like the Linux fbdev model.

Pardon me for saying this, but... I don't actually care about them. It's the 
fact that MIT is a *huge* college and likely has money to pursue license 
issues and similar, and the BSD license, IIRC, states that the code is 
"Property of the Board of Regents" of, IIRC, UC Berkeley. UC Berkeley is 
again, a rather huge college, and has the resources to pursue license issues.

For that reason alone I am going to try to keep any code I produce clean. I 
could care less if BSD or an MIT OS project use the code - I'm writing it for 
Linux.

DRH
