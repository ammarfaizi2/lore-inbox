Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290605AbSARFlK>; Fri, 18 Jan 2002 00:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290606AbSARFlB>; Fri, 18 Jan 2002 00:41:01 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:12929 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S290605AbSARFku>; Fri, 18 Jan 2002 00:40:50 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: lists@darkcore.net
Date: Fri, 18 Jan 2002 16:43:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15431.46568.368483.759207@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why won't ext3 & 2.4.19 export the root?
In-Reply-To: message from John Lange on Tuesday January 8
In-Reply-To: <Pine.LNX.4.40.0201081603290.795-100000@CTECHjohnl.clearoption.com>
	<Pine.LNX.4.40.0201081634550.1027-100000@CTECHjohnl.clearoption.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday January 8, lists@darkcore.net wrote:
> Further to this issue, here is the output from exportfs -vr
> 
> ---- snip ----
> 
> # exportfs -vr
> exporting 205.x.x.x:/var/www
> exporting 205.x.x.x:/
> reexporting 205.x.x.x:/var/www to kernel
> exporting 205.x.x.x:/ to kernel
> 205.x.x.x:/: Invalid argument

Is /var/www on the same filesystem as / ???
If so, there is no need to export both, and if you try you get this
error.

Just export /

NeilBrown

> 
> --- snip ---
> Any help would be apreciated.
> 
> Thanks
> 
> John Lange
> 
> On Tue, 8 Jan 2002, John Lange wrote:
> 
> > I recently upgraded my kernel from 2.4.9 to 2.4.19 and at the same time
> > started using ext3.
> >
> > Since that change, I can no longer export and/or mount the "/" of this
> > machine for backup purposes. This is a significant problem since remotely
> > mounting the file system is our primary (only) way of backing up several
> > of our production machines.
> >
> > Exporting and mounting other than the root works normally.
> >
> > Here is the /etc/exports for reference.
> >
> > /            205.x.x.x(ro,no_root_squash)
> > /var/www     205.x.x.x(ro,no_root_squash)
> >
> > I've googled and searched the mailing list archives but didn't find any
> > mention of this.
> >
> > Can someone please tell me what I need to change in order to export the
> > root?
> >
> > Thanks.
> >
> > John Lange
> >
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
