Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWHGSEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWHGSEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 14:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWHGSEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 14:04:53 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:44214 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932259AbWHGSEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 14:04:52 -0400
Date: Mon, 7 Aug 2006 20:00:49 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Daniel Rodrick <daniel.rodrick@gmail.com>
cc: "H. Peter Anvin" <hpa@zytor.com>,
       Linux Newbie <linux-newbie@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Univeral Protocol Driver (using UNDI) in Linux
In-Reply-To: <292693080608070911g57ae1215qd994e03b9dd87b66@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0608071958160.3365@yvahk01.tjqt.qr>
References: <292693080608070339p6b42feacw9d8f27a147cf1771@mail.gmail.com> 
 <44D7579D.1040303@zytor.com> <292693080608070911g57ae1215qd994e03b9dd87b66@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Agreed. But still having a single driver for all the NICs would be
> simply GREAT for my setup, in which all the PCs will be booted using
> PXE only. So apart from performance / relilability issues, what are
> the technical roadblocks in this?

Netboot, in the current world, could be done like this:

1. Grab the PXE ROM code chip manufacturers offer in case your network card 
does not support booting via PXE yet and write it to an EPROM which most 
PCI network cards have a socket for

2. Use PXELINUX, boot that with the help of the PXE ROM code

3. Put all drivers needed into the kernel or initrd; or send out different 
initrds depending on the DHCP info the PXE client sent. 


Jan Engelhardt
-- 
