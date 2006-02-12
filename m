Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWBLKcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWBLKcr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 05:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWBLKcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 05:32:47 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:44989 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964837AbWBLKcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 05:32:46 -0500
Date: Sun, 12 Feb 2006 11:32:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: iSteve <isteve@rulez.cz>
cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org,
       Peter Osterlund <petero2@telia.com>
Subject: Re: Packet writing issue on 2.6.15.1
In-Reply-To: <20060212092315.10f3e0e2@silver>
Message-ID: <Pine.LNX.4.61.0602121129590.25363@yvahk01.tjqt.qr>
References: <20060211103520.455746f6@silver> <m3r76a875w.fsf@telia.com>
 <20060211124818.063074cc@silver> <m3bqxd999u.fsf@telia.com>
 <20060211170813.3fb47a03@silver> <43EE446C.8010402@cfl.rr.com>
 <20060211211440.3b9a4bf9@silver> <43EE8B20.7000602@cfl.rr.com>
 <20060212092315.10f3e0e2@silver>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The thing is, I'd like to be able to set up a CDRW for packet writing and burn
>some data there (not necessarily UDF filesystem, it should be able to, for
>example, undergo encryption; and it may not be UDF filesystem at all) without
>actually having to use UDF and packet writing on the burning side...
>
>That is: Set up CDRW for packet writing. Burn something non-UDF there. Move it
>elsewhere. Use packet writing to access it r/w. Can I do that?:) I've been
>playing with cdrecord's -packet and pktsize options atm, the only thing I got
>was a CDRW that apparently blocks all reading.

Like...?

  cdrwtool -d /dev/hdb -q
  pktsetup 0 /dev/hdb

"Burning something non-udf there":
  mkfs.xfs /dev/pktcdvd/0
  mkisofs -o /dev/pktcdvd/0 somefiles
  tar -cf /dev/pktcdvd/0 somemorefiles

Anything.


Jan Engelhardt
-- 
