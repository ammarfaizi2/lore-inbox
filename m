Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287892AbSABSmU>; Wed, 2 Jan 2002 13:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287893AbSABSmL>; Wed, 2 Jan 2002 13:42:11 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:11525 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S287890AbSABSlx>; Wed, 2 Jan 2002 13:41:53 -0500
Date: Wed, 2 Jan 2002 19:41:50 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Krzysztof Oledzki <ole@ans.pl>
Cc: Brian <hiryuu@envisiongames.net>, linux-kernel@vger.kernel.org
Subject: Re: Two hdds on one channel - why so slow?
Message-ID: <20020102194150.A14140@suse.cz>
In-Reply-To: <0GPA00BK988OBK@mtaout45-01.icomcast.net> <Pine.LNX.4.33.0201021808490.9573-100000@dark.pcgames.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201021808490.9573-100000@dark.pcgames.pl>; from ole@ans.pl on Wed, Jan 02, 2002 at 06:21:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 06:21:25PM +0100, Krzysztof Oledzki wrote:
> 
> 
> On Tue, 1 Jan 2002, Brian wrote:
> 
> > This is an inherent quirk (SCSI folks would say brain damage) in IDE.
> >
> > Only one drive on an IDE chain may be accessed at once and only one
> > request may go to that drive at a time.  Therefore, the maximum you could
> > hope for in that test is half speed on each.  Throw in the overhead of
> > continuously hopping between them and 12MB is no surprise.
> 
> So?!? This ATA100 and ATA133 standards do not make any sens? It is not
> possible to have more than 66 MB/sec with on drive and is seems that it is
> not possible to use more than ~30MB/sek of 100 or 133 MB/sec ATA100/133
> bus speed with two HDDs. Oh :(((
> 
> Another question - why ATA100/ATA66 HDDs are so slow with UDMA33?
> With new IBM 60 GB IC35L060AVER07-0 I have much more than 33 MB/sec with
> ATA100 and only 24 MB/sec with UDMA33 (Asus P2B with IntelBX). New 80GB Seagates
> (Baracuda IV) have the same problem.

Actually 24 MB/sec is quite a miracle with UDMA33. I'd expect values
around 16 MB/sec. Because, as far as I know, unlike SCSI, IDE doesn't do
concurrent reads and transfers (except for readahead), effectively
halving the interface transfer speed.

-- 
Vojtech Pavlik
SuSE Labs
