Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270295AbTHLMbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 08:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270319AbTHLMbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 08:31:50 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:5386 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S270295AbTHLMbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 08:31:47 -0400
Date: Tue, 12 Aug 2003 14:31:46 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 cannot mount root fs
Message-ID: <20030812123146.GG15996@gamma.logic.tuwien.ac.at>
References: <20030810211745.GA5327@gamma.logic.tuwien.ac.at> <20030810154343.351aa69d.akpm@osdl.org> <20030811053437.GA19040@gamma.logic.tuwien.ac.at> <20030811145940.GF4562@www.13thfloor.at> <20030811154009.GE6763@gamma.logic.tuwien.ac.at> <20030811185326.GB25186@www.13thfloor.at> <20030811215058.GA24474@gamma.logic.tuwien.ac.at> <20030811222134.GA10481@www.13thfloor.at> <20030812053956.GA7108@gamma.logic.tuwien.ac.at> <20030812122639.GA27114@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030812122639.GA27114@www.13thfloor.at>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 12 Aug 2003, Herbert Pötzl wrote:
> my assumption would be that you use the lilo root option
> and do not pass the root= as kenel boot option ...
> 
> I would suggest to give append="root=/dev/hdb1" a try,
> and/or update lilo or change to grub ...

I tried *all* the variants with passing
	root=....
on the lilo line, so it is passed to the kernel and not via rdev or
something else.

> > > (as well as the lines regarding hdb discovery ;)
> > 
> > Why? Isnt't this line what you meant: (From my previous email)
> 
> because IC35L040AVER07-0 .... is very unlikely to be a kernel message ...

The hard disk is an IC35L...:
(running 2.4.22-rc2):

[~] cat /proc/ide/hdb/model 
IC35L040AVER07-0

> > > > hdb: max request size 128 KiB
> > > > hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
> > > >         hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 hdb11 hdb12>


So it *IS* recognized. But why not mounted.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
WIKE (vb.)
To rip a piece of sticky plaster off your skin as fast as possible in
the hope that it will (a) show how brave you are, and (b) not hurt.
			--- Douglas Adams, The Meaning of Liff
