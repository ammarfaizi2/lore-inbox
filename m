Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267820AbUG3UOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267820AbUG3UOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267821AbUG3UOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:14:08 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:7561 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S267820AbUG3UN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:13:57 -0400
Date: Fri, 30 Jul 2004 22:13:57 +0200
From: Martin Mares <mj@ucw.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Exposing ROM's though sysfs
Message-ID: <20040730201357.GA5391@ucw.cz>
References: <20040730194634.GA4851@ucw.cz> <20040730200359.80825.qmail@web14922.mail.yahoo.com> <20040730201052.GA5249@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730201052.GA5249@ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do I understand it correctly that the ROM-in-sysfs hack is intended only
> for debugging? If it is so, I do not see why we should do anything complicated
> in order to avoid root shooting himself in the foot.

... for which the config space access code already sets the precedent --
there exist (rare) devices which have configuration registers with side
effects on reads, making it possible to produce SCSI errors or even crash
the system by just dumping the config space. Even on these devices, the
kernel does not attempt to forbid reading of these registers via sysfs.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A bug in the code is worth two in the documentation.
