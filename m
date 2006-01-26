Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWAZBKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWAZBKZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 20:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWAZBKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 20:10:25 -0500
Received: from webmail.terra.es ([213.4.149.12]:26956 "EHLO
	csmtpout1.frontal.correo") by vger.kernel.org with ESMTP
	id S1751250AbWAZBKX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 20:10:23 -0500
Date: Thu, 26 Jan 2006 02:13:51 +0100 (added by postmaster@terra.es)
From: <grundig@teleline.es>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: axboe@suse.de, matthias.andree@gmx.de, schilling@fokus.fraunhofer.de,
       jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-Id: <20060126020951.14ebc188.grundig@teleline.es>
In-Reply-To: <20060125231422.GB2137@merlin.emma.line.org>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
	<Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
	<20060125144543.GY4212@suse.de>
	<Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
	<20060125153057.GG4212@suse.de>
	<43D7AF56.nailDFJ882IWI@burner>
	<20060125181847.b8ca4ceb.grundig@teleline.es>
	<20060125173127.GR4212@suse.de>
	<43D7C1DF.1070606@gmx.de>
	<20060125182552.GB4212@suse.de>
	<20060125231422.GB2137@merlin.emma.line.org>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 26 Jan 2006 00:14:22 +0100,
Matthias Andree <matthias.andree@gmx.de> escribió:

> Great. There's a better way, but it is not necessary. Let Linux-specific
> applications use it for their benefit, but a portable application isn't
> going that way because it's too much effort. If a simpler interface that
> can be shared with half a dozen other system exists, the portable
> application will use that and ignore better interfaces.

It's too "much effort"? Basically, what linux is asking is that cdrecord
stop wasting efforts trying to implement its own solution. Linux is 
asking cdrecord to use SG_IO and leave device discovery and data transport
issues to the platform.

Linux doesn't even need -scanbus for example. You could compile out that
code. Device discovery is done by the platform - I find _scary_ that other
"modern" operative systems don't have a way of providing device discovery
services in 2006 and that a external app is needed but hey, people is free
to design their operative system as they like. Linux provides it and leaves
Schilling time to focus in other things. In my book, that's not "too much
effort", is "less effort". If someone bugs you because SG_IO doesn't work
just tell him to report the problem here - in fact cdrecord already has a
"friendly" warning about "linux-2.5 and newer". The cdrecord low level
scsi driver for SG_IO should be much simpler than all the others...
