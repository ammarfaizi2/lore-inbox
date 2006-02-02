Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422962AbWBBKOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422962AbWBBKOr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWBBKOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:14:47 -0500
Received: from mail.gmx.de ([213.165.64.21]:33973 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932420AbWBBKOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:14:46 -0500
X-Authenticated: #428038
Date: Thu, 2 Feb 2006 11:14:41 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jengelh@linux01.gwdg.de, mrmacman_g4@mac.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       James@superbug.co.uk, j@bitron.ch, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060202101441.GA10554@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	jengelh@linux01.gwdg.de, mrmacman_g4@mac.com, mj@ucw.cz,
	linux-kernel@vger.kernel.org, James@superbug.co.uk, j@bitron.ch,
	acahalan@gmail.com
References: <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner> <1138642683.7404.31.camel@juerg-pd.bitron.ch> <43DF3C3A.nail2RF112LAB@burner> <mj+md-20060131.104748.24740.atrey@ucw.cz> <43DF65C8.nail3B41650J9@burner> <Pine.LNX.4.61.0602011612520.22529@yvahk01.tjqt.qr> <43E1D417.nail4MI11WTFI@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E1D417.nail4MI11WTFI@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-02:

> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> 
> > It's shorter than /dev/c0t0d0s0? Well, I think it's because people think 
> > in terms of connectors (my drive is IDE therefore it must be hdc) rather 
> > than protocol (my drive does ATAPI therefore it must be 
> > /dev/scsi/c0t0d0s0).
> 
> Is there any reason why the people with small PCs should dominate the 
> people with big machines?

No side should dominate.

> If you use /dev/hd*, you loose control after you add more than ~ 6-10 disks.

I don't see how a letter such as /dev/hdo /dev/hdp /dev/hdq is much
different than an opaque number tuple as 1,15,0 1,16,0 1,17,0... either
is a string with systematic generation, and that's about it.

I'm still wondering why mtst (mid-layer access to control tape drives)
is happy with /dev/nst0 nst1 ... (device name) and cdrecord (or its
author) isn't. cdrecord or libscg should be agnostic of these schemas
and take any opaque string that works properly for the given system
without complaining. It can invent any numbering scheme it likes, but
requesting that the kernel does it if it has no further use for it is
barking up the wrong tree.

-- 
Matthias Andree
