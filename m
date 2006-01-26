Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWAZPet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWAZPet (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 10:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWAZPet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 10:34:49 -0500
Received: from webmail.terra.es ([213.4.149.12]:9068 "EHLO
	csmtpout1.frontal.correo") by vger.kernel.org with ESMTP
	id S932357AbWAZPet convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 10:34:49 -0500
Date: Thu, 26 Jan 2006 16:38:16 +0100 (added by postmaster@terra.es)
From: <grundig@teleline.es>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: schilling@fokus.fraunhofer.de, rlrevell@joe-job.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, axboe@suse.de, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-Id: <20060126163414.f00811e2.grundig@teleline.es>
In-Reply-To: <43D8988F.nailDTH21LS0G@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
	<Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
	<20060125144543.GY4212@suse.de>
	<Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
	<20060125153057.GG4212@suse.de>
	<43D7AF56.nailDFJ882IWI@burner>
	<20060125181847.b8ca4ceb.grundig@teleline.es>
	<43D8988F.nailDTH21LS0G@burner>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 26 Jan 2006 10:38:23 +0100,
Joerg Schilling <schilling@fokus.fraunhofer.de> escribió:

> > > It serves the need of GUI programs for cdrercord and allows them to retrieve 
> > > and list possible drives of interest in a platform independent way.
> >
> > But this is not neccesary at all, since linux platform already provides ways to
> > retrieve and list possible drives....
> 
> Interesting: You claim that the Linux platform provides ways to retrieve 
> the needed information on FreeBSD, MS-WIN, ....?


No. I claim that linux does have ways of retrieving the needed information.

You can keep providing your own solution on freebsd, win & friends if
you want, but _why_ do you want to do it in linux when linux can do it
by itself?? There's no reason why cdrecord should care about duplicating
existing functionality when the platform can provide that functionality
for free. Let cdrecord (name it libscg) use SG_IO and let users use
the /dev/hd*.

The case of cdrecord remembers me of X.org, which used/is poking /dev/mem
directly to discover PCI devices and/or play with framebuffers instead of
using the available APIs in linux. Except that the X.org people wants to
solve (or has already solved) such problems using the native available
APIS instead of keeping their own solutions. Well-written cross-platform
software implements all the features when needed by all the platforms as
a whole but only uses such features when a particular platform needs it,
unless using one of those features is a nightmare (which is not the
case of SG_IO IMHO)
