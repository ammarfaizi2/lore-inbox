Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275029AbTHLFkQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 01:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275050AbTHLFkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 01:40:16 -0400
Received: from [128.130.175.20] ([128.130.175.20]:39174 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S275029AbTHLFkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 01:40:07 -0400
Date: Tue, 12 Aug 2003 07:39:56 +0200
To: linux-kernel@vger.kernel.org
Cc: Herbert =?iso-8859-15?Q?P=F6tzl?= <herbert@13thfloor.at>
Subject: Re: 2.6.0-test3 cannot mount root fs
Message-ID: <20030812053956.GA7108@gamma.logic.tuwien.ac.at>
References: <01a201c35e65$0536ef60$ee52a450@theoden> <3F34D0EA.8040006@rogers.com> <20030810211745.GA5327@gamma.logic.tuwien.ac.at> <20030810154343.351aa69d.akpm@osdl.org> <20030811053437.GA19040@gamma.logic.tuwien.ac.at> <20030811145940.GF4562@www.13thfloor.at> <20030811154009.GE6763@gamma.logic.tuwien.ac.at> <20030811185326.GB25186@www.13thfloor.at> <20030811215058.GA24474@gamma.logic.tuwien.ac.at> <20030811222134.GA10481@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030811222134.GA10481@www.13thfloor.at>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 12 Aug 2003, Herbert Pötzl wrote:
> > > -----------
> > > VFS: Cannot open root device "hdb1" or unknown-block(0,0)
> > > Please append a correct "root=" boot option
> > > -----------
> > 
> > Yes, it is like this.
> 
> like or exactly like? 

Ok, here is the exact output with different root= options:

root=/dev/hdb1
	Cannot open root device "<NULL>" or hdb1
	Please append a correct "root=" boot option

root=0341
	Cannot open root device "0341" or hdb1
	Please append a correct "root=" boot option

root=03:41
	Cannot open root device "03:41" or unknown-block(0,0)
	Please append a correct "root=" boot option

root=03:65
	Cannot open root device "03:65" or unknown-block(0,0)
	Please append a correct "root=" boot option

> (as well as the lines regarding hdb discovery ;)

Why? Isnt't this line what you meant: (From my previous email)

> > hdb: IC35L040AVER07-0 ....
...
> > hdb: max request size 128 KiB
> > hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
> >         hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 hdb11 hdb12>
...

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
FROSSES (pl.n.)
The lecherous looks exchanged between sixteen-year-olds at a party
given by someone's parents.
			--- Douglas Adams, The Meaning of Liff
