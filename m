Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbVIZTsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVIZTsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 15:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVIZTsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 15:48:19 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:50305 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932487AbVIZTsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 15:48:19 -0400
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
References: <Pine.LNX.4.60.0509242057001.4899@poirot.grange>
	<m3slvtzf72.fsf@telia.com>
	<Pine.LNX.4.60.0509252026290.3089@poirot.grange>
	<m34q873ccc.fsf@telia.com>
	<Pine.LNX.4.60.0509262122450.4031@poirot.grange>
From: Peter Osterlund <petero2@telia.com>
Date: 26 Sep 2005 21:48:14 +0200
In-Reply-To: <Pine.LNX.4.60.0509262122450.4031@poirot.grange>
Message-ID: <m3slvr1ugx.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:

> On Mon, 26 Sep 2005, Peter Osterlund wrote:
> 
> > Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:
> > 
> > > Besides, it works under 2.6.12-rc5...
> > 
> > What gcc versions were used when compiling the kernels? (Boot both
> > kernels, run "cat /proc/version" to find out.)
> 
> Well, they are somewhat different:
> 
> Linux version 2.6.12-rc5 (lyakh@poirot.grange) (gcc version 3.3.4 (Debian 
> 1:3.3.4-13)) #1 Sun May 29 22:53:31 CEST 2005
> 
> Linux version 2.6.13.1 (lyakh@poirot.grange) (gcc version 3.3.5 (Debian 
> 1:3.3.5-13)) #1 Sat Sep 17 11:57:51 CEST 2005
> 
> ... No gcc-4.0, but still - 3.3.4 and 3.3.5... I could try recompiling 
> 2.6.12 with 3.3.5... Do you REALLY believe it could be the reason?

No, not 3.3.4 vs 3.3.5.

> > I just discovered that the driver doesn't work correctly on my laptop
> > if I use "gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)" from Fedora
> > Core 4. "pktsetup 0 /dev/hdc ; cat /proc/driver/pktcdvd/pktcdvd0"
> > OOPSes. If I use gcc32 it does seem to work though.
> 
> Doesn't Oops for me under 2.6.13.1 compiled with 3.3.5, that's where I get 
> errors.

OK. Another option since you have one good and one bad kernel, is to
try to find the point in time where it broke. If you are a git user,
you can use the "git bisect" method. If not, you can use -rc releases
from ftp.kernel.org.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
