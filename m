Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272289AbTHNLEH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 07:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272277AbTHNLEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 07:04:06 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:5116 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S272289AbTHNLEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 07:04:05 -0400
Subject: Re: [PATCH] ide: limit drive capacity to 137GB if host
	doesn't	support LBA48
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F3B53CC.8030209@cyberone.com.au>
References: <200308140324.45524.bzolnier@elka.pw.edu.pl>
	 <1060851207.5535.15.camel@dhcp23.swansea.linux.org.uk>
	 <3F3B53CC.8030209@cyberone.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060859006.5569.31.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 14 Aug 2003 12:03:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-14 at 10:18, Nick Piggin wrote
> >This change is a bad idea. Its called "addressing" because that is what
> >it is about (see SATA and ATA specs). In future SATA addressing becomes
> >a 0,1,2 value because 48bits isnt enough, it may get more forms beyond
> >that.
> >
> 
> Wow! Isn't that over 100 thousand TB? ;)

It depends how they are used and its more about message formats. LBA48 is
a pretty evil hack based on keeping some compatibility by writing some
registers twice and having the drive know about it.


