Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVIWIvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVIWIvv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 04:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVIWIvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 04:51:51 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:58756 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750817AbVIWIvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 04:51:50 -0400
Date: Fri, 23 Sep 2005 10:51:54 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Valdis.Kletnieks@vt.edu
Cc: "Artem B. Bityutskiy" <dedekind@yandex.ru>, Pavel Machek <pavel@ucw.cz>,
       Peter Menzebach <pm-mtd@mw-itcon.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: data loss on jffs2 filesystem on dataflash
Message-ID: <20050923085154.GA7522@wohnheim.fh-wedel.de>
References: <43292AC6.40809@mw-itcon.de> <43292E16.70401@yandex.ru> <43292F91.9010302@mw-itcon.de> <432FE1EF.9000807@yandex.ru> <432FEF55.5090700@mw-itcon.de> <433006D8.4010502@yandex.ru> <20050920133244.GC4634@wohnheim.fh-wedel.de> <20050921190759.GC467@openzaurus.ucw.cz> <43328C07.9070001@yandex.ru> <200509221646.j8MGkYo3017314@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200509221646.j8MGkYo3017314@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 September 2005 12:46:33 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 22 Sep 2005 14:48:39 +0400, "Artem B. Bityutskiy" said:
> 
> > Joern meant that if HDD starts a block write operation, it will 
> > accomplish it even if power-fail happens (probably there are some 
> > capacitors there). So, it is impossible, say, that HDD has written one 
> > half of a sector and has not written the other half.
> 
> Hard drives contain capacitors to prevent writing of runt sectors on
> a powerfail?  Didn't we go around this a while ago and decide it's mostly
> urban legend, and that plenty of people have seen runt/bad sectors?

Yep.  I did _not_ say anything about finishing to write a sector.
What I said was that there is only one case of a started and
unfinished sector: it contains partially old and partially new data
and nothing else.

And the difference (one of them, at least) between hard disks and
flash is the "and nothing else" part.  Flash may contain other
information as well or even be in a partially erased state, randomly
flipping bits in the future or not accepting writes.

Jörn

-- 
When in doubt, use brute force.
-- Ken Thompson
