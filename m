Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314783AbSE2Knd>; Wed, 29 May 2002 06:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314787AbSE2Knc>; Wed, 29 May 2002 06:43:32 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:8680 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S314783AbSE2Knb>; Wed, 29 May 2002 06:43:31 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Nick Evgeniev" <nick@octet.spb.ru>
Date: Wed, 29 May 2002 20:43:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15604.45243.291277.197140@notabene.cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre8-ac5 ide & raid0 bugs
In-Reply-To: message from Nick Evgeniev on Wednesday May 29
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday May 29, nick@octet.com wrote:
> Hi,
> 
> I wrote about ide problems with 2.4.19-pre8 a few days ago (it just trashed
> filesystem in a couple hours) & I was told to try 2.4.19-pre8-ac5 it was a
> little bit better though every 5-8 hours I've got ide errors in log (at
> least it didn't crash my reiserfs volumes yet):
---snip--
> >-----------------------------
> But now I've got even more bugs in log like:
> >-----------------------------
> May 29 11:28:06 vzhik kernel: raid0_make_request bug: can't convert block
> across chunks or bigger than 16k 37713311 4
> May 29 11:28:06 vzhik kernel: raid0_make_request bug: can't convert block
> across chunks or bigger than 16k 37713343 4

This is a request for a 4K block that is not 4K aligned... this
shouldn't happen.
Are you using LVM or something to partition the raid0 array?
... though I seem to recall that LVM always partitions in multiples of
4K so that shouldn't be a problem.

More detais of configuration please.

> The question is -- What I have to try to get WORKING ide driver under
> "STABLE" kernel?

Use SCSI :-?

NeilBrown
