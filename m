Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270772AbTGNUAf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270773AbTGNUAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:00:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:51349 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270772AbTGNT5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:57:18 -0400
Date: Mon, 14 Jul 2003 17:09:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jens Axboe <axboe@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Chris Mason <mason@suse.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
In-Reply-To: <20030714195138.GX833@suse.de>
Message-ID: <Pine.LNX.4.55L.0307141708210.8994@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva>
 <20030710135747.GT825@suse.de> <1057932804.13313.58.camel@tiny.suse.com>
 <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com>
 <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random>
 <20030714054918.GD843@suse.de> <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva>
 <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jul 2003, Jens Axboe wrote:

> Some initial results with the attached patch, I'll try and do some more
> fine grained tomorrow. Base kernel was 2.4.22-pre5 (obviously), drive
> tested is a SCSI drive (on aic7xxx, tcq fixed at 4), fs is ext3. I would
> have done ide testing actually, but the drive in that machine appears to
> have gone dead. I'll pop in a new one tomorrow and test on that too.
>
> no_load:
> Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> 2.4.22-pre5            2        134     196.3   0.0     0.0     1.00
> 2.4.22-pre5-axboe      3        133     196.2   0.0     0.0     1.00
> ctar_load:
> Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> 2.4.22-pre5            3        235     114.0   25.0    22.1    1.75
> 2.4.22-pre5-axboe      3        194     138.1   19.7    20.6    1.46
> xtar_load:
> Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> 2.4.22-pre5            3        309     86.4    15.0    14.9    2.31
> 2.4.22-pre5-axboe      3        249     107.2   11.3    14.1    1.87
> io_load:
> Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> 2.4.22-pre5            3        637     42.5    120.2   18.5    4.75
> 2.4.22-pre5-axboe      3        540     50.0    103.0   18.1    4.06
> io_other:
> Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> 2.4.22-pre5            3        576     47.2    107.7   19.8    4.30
> 2.4.22-pre5-axboe      3        452     59.7    85.3    19.5    3.40
> read_load:
> Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> 2.4.22-pre5            3        150     181.3   8.1     9.3     1.12
> 2.4.22-pre5-axboe      3        152     178.9   8.2     9.9     1.14

Awesome. I'll add it in -pre6.

Thanks a lot Jens.

