Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUHJJiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUHJJiS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUHJJiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:38:18 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:7315 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263117AbUHJJiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:38:12 -0400
Date: Tue, 10 Aug 2004 11:38:12 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: axboe@suse.de, James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk,
       eric@lammerts.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810093812.GH10361@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	axboe@suse.de, James.Bottomley@steeleye.com,
	alan@lxorguk.ukuu.org.uk, eric@lammerts.org,
	linux-kernel@vger.kernel.org
References: <200408091443.i79EhYKP010656@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408091443.i79EhYKP010656@burner.fokus.fraunhofer.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2004-08-09:

> 
> >From: Jens Axboe <axboe@suse.de>
> 
> >> Please try again after you had a look into the cdrtools sources.
> >> 
> >> Cdrecord also needs privilleges to lock memory and to raise prioirity.
> 
> >They are not required, or at least not with the version I use. It warns
> >of failing to set priority and lock memory, I can continue fine though.
> >With the casual burning of CDs I do, it's never been a problem.
> 
> You should believe people who know better.....

J�rg, this is insulting. Who knows better than Jens if his computer has
needed burn-proof and if his writes have been successful?  You for one
don't. I don't either but at least I don't claim to.

There may be problems with insufficient privileges, problems when pages
aren't locked into memory, problems when cdrecord doesn't have realtime
priority, but that doesn't mean everyone encounters them.

The maintainer's (your) definition of "works" or "no problem" and the
end user's definition of "works" or "no problem" differ by an order of
magnitude. Such is a developer's life.

So consider refining the warnings and tell users what CAN happen if they
continue without root privileges and add a 15 s timer so they can read,
abort and retry with sudo.

-- 
Matthias Andree

NOTE YOU WILL NOT RECEIVE MY MAIL IF YOU'RE USING SPF!
Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
