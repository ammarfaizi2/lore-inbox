Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRBZRaH>; Mon, 26 Feb 2001 12:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129190AbRBZR35>; Mon, 26 Feb 2001 12:29:57 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:55566 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129111AbRBZR3p>; Mon, 26 Feb 2001 12:29:45 -0500
Date: Mon, 26 Feb 2001 11:24:07 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Guest section DW <dwguest@win.tue.nl>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org,
        aeb@cwi.nl
Subject: Re: partition table: chs question
Message-ID: <20010226112407.C23495@vger.timpanogas.org>
In-Reply-To: <20010225163534.A12566@dungeon.inka.de> <20010225224729.A16353@win.tue.nl> <002201c09f87$5ce75640$f6976dcf@nwfs> <20010226041156.A16707@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010226041156.A16707@win.tue.nl>; from dwguest@win.tue.nl on Mon, Feb 26, 2001 at 04:11:56AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2001 at 04:11:56AM +0100, Guest section DW wrote:
> On Sun, Feb 25, 2001 at 05:02:09PM -0700, Jeff V. Merkey wrote:
> 
> > Please also check vger.timpanogas.org/nwfs/nwfs.tar.gz:disk.c for NetWare
> > specific calculations of the CHS values, a different method is used for
> > NetWare partitions vs. everything else (Novell just had to be different).
> 
> > > On Sun, Feb 25, 2001 at 04:35:34PM +0100, Andreas Jellinghaus wrote:
> > >
> > > > for partitions not in the first 8gb of a harddisk, what
> > > > should the c/h/s start and end value be ?
> > > >
> > > > most fdisks seem to set start and end to 255/63/1023.
> > > > but partition magic creates partitions with start set to
> > > > 0/1/1023 and end set to 255/63/1023, and detects a problem
> > > > if start is set to 255/63/1023.
> 
> Good. I added this to
> http://www.win.tue.nl/~aeb/partitions/partition_types-2.html#above1024chs
> 
> Now that I looked at this disk.c anyway: it has a table of
> partition types, and it seems I collect these.
> (See http://www.win.tue.nl/~aeb/partitions/partition_types-1.html )
> Are types 57 and 77, labeled "VNDI Partition", actually in use?

No.  They are not.  65, and 77 are the ones in use.  Novell was using 
67 for Wolf Mountain, but for NSS, they are exclusively using 
"69" (I know who at Novell picked this number, and I'll give you 
three guesses what is always on his mind).  

Jeff




> 
> Andries
