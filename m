Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTFJOXg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 10:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTFJOXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 10:23:36 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:47595 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262850AbTFJOXe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 10:23:34 -0400
Date: Tue, 10 Jun 2003 16:36:44 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Stefano Rivoir <s.rivoir@gts.it>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE performances, 2.4 vs 2.5
In-Reply-To: <3EE5A2C3.1060303@gts.it>
Message-ID: <Pine.SOL.4.30.0306101631480.27439-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



IDE layer is basically the same in 2.4.21-rc and 2.5.70 (but not in -bk).
If you check 2.4.21-rc against 2.5.70 and results will be similar,
it means its not IDE performance problem, but block layer, VM or FS.

Regards,
--
Bartlomiej

On Tue, 10 Jun 2003, Stefano Rivoir wrote:

> Noting that 2.5 is much slower than 2.4 on disk operations (you *touch*
> it when you have not-so-fast machine and use KDE, for example), I've
> written a silly test that fwrite/fread a single 100Mb file, char by
> char, and timing it I have results that I can't understand very well. Of
> course, same machine, same hdparm settings, same processes running
> (none, it's a notebook without server processes). I've run these test
> several time, the results are always more or less the same (ext2):

fwrite/fread is not a good test for IDE performance.

> 2.4.19
>
>    read:    real    0m15.822s
>             user    0m15.180s
>             sys     0m0.270s
>
>    write:   real    0m12.524s
>             user    0m11.800s
>             sys     0m0.690s
>
> 2.5.70 (up to -bk14, and -mm6)
>
>    read:    real    0m20.790s
>             user    0m14.372s
>             sys     0m0.949s
>
>    write:   real    0m13.148s
>             user    0m11.901s
>             sys     0m0.665
>
> Writing does not drop, but reading has a 6 seconds difference between
> user+sys and real that I can't figure out. And the total difference is
> "huge". Actually, using anything that touches the disk (it can be a
> trivial "aptitude" loading the cache, or a complex KDE) slows down.
>
> I've run these tests on a HP Omnibook w/Celeron, but I have the same
> slow down on a Athlon K7.
>
> Is it anyway "normal", something I should expect upgrading from 2.4 to
> 2.5/2.6? Or there should be something I should check more accurately?
>
> Bye all.
>
> --
> Stefano RIVOIR
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

