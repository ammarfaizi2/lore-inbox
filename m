Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbULaVsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbULaVsF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 16:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbULaVsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 16:48:05 -0500
Received: from pri-dns2.mtco.com ([207.179.200.252]:15546 "HELO
	pri-dns2.mtco.com") by vger.kernel.org with SMTP id S262155AbULaVsC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 16:48:02 -0500
From: Tom Felker <tfelker2@uiuc.edu>
To: gene.heskett@verizon.net
Subject: Re: the umount() saga for regular linux desktop users
Date: Fri, 31 Dec 2004 15:48:11 -0600
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, ofeeley@gmail.com,
       William <wh@designed4u.net>
References: <200412311741.02864.wh@designed4u.net> <2b8348ba041231094816d02456@mail.gmail.com> <200412311322.14359.gene.heskett@verizon.net>
In-Reply-To: <200412311322.14359.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412311548.11614.tfelker2@uiuc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 December 2004 12:22 pm, Gene Heskett wrote:

> There are some times when the usual 5 second flush schedule should be
> tossed out the window, and the data written immediately.  A quickly
> unpluggable usb memory dongle is a prime candidate to bite the user
> precisely where it hurts.  Floppies also fit this same scenario, I
> don't know at the times I've written an image with dd, got up out of
> my chair and went to the machine and slapped the eject button to
> discover to my horror, that when my hand came away from the button
> with disk in hand, the frigging access led was now on that wasn't
> when I tapped the button.

For that you should add "sync" as an option when mounting the filesystem, in 
which case writes won't return until the data has actually been written.  man 
mount doesn't mention that being implemented for FAT, though - is that 
accurate, and if so, shouldn't it be?

-- 
Tom Felker, <tcfelker@mtco.com>
<http://vlevel.sourceforge.net> - Stop fiddling with the volume knob.

McBride: "I have here in my hand a list of two hundred and five..."
