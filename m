Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275968AbRJPLkY>; Tue, 16 Oct 2001 07:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRJPLkP>; Tue, 16 Oct 2001 07:40:15 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:1243 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S275968AbRJPLkE>; Tue, 16 Oct 2001 07:40:04 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Date: Tue, 16 Oct 2001 21:40:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15308.7334.369332.30384@notabene.cse.unsw.edu.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: very slow RAID-1 resync
In-Reply-To: message from Jeffrey W. Baker on Monday October 15
In-Reply-To: <15307.44327.541413.250400@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.33.0110152052510.415-100000@desktop>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 15, jwbaker@acm.org wrote:
> On Tue, 16 Oct 2001, Neil Brown wrote:
> 
> > On Monday October 15, hahn@physics.mcmaster.ca wrote:
> > > > raid1d and raid1syncd are barely getting any CPU time on this otherwise
> > > > idle SMP system.
> > >
> > > I noticed this too, on a uni, raid5 system;
> > > the resync-throttling code doesn't seem to work well.
> >
> > It works great for me...
> > What sort of drives do you have? SCSI? IDE? are you using both master
> > and slave on an IDE controller?
> 
> 15,000 RPM SCSI u160 disks.

Just like mine.....

I would expect around 30Mb/sec when resyncing a single mirrored pair,
and slightly less than that on each if you are syncing two mirrored
pairs at once, as you would be getting close to the theoretical buss
max (to resync two pairs at once at 30Mb/sec each you would need to
but pushing 120Mb/sec over the buss, and I doubt that you would get
that from u160 in practice).

Thats a big more than the 20Mb/sec that you report, but less than the
60Mb/sec that you hoped for...

NeilBrown

> 
> -jwb
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
