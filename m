Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262510AbRENViD>; Mon, 14 May 2001 17:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262511AbRENVhx>; Mon, 14 May 2001 17:37:53 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:40458 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262510AbRENVhk>; Mon, 14 May 2001 17:37:40 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 15 May 2001 07:37:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15104.20483.15936.305056@notabene.cse.unsw.edu.au>
Cc: neilb@cse.unsw.edu.au (Neil Brown),
        torvalds@transmeta.com (Linus Torvalds),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: message from Alan Cox on Monday May 14
In-Reply-To: <15104.17957.253821.765483@notabene.cse.unsw.edu.au>
	<E14zPl9-0001S9-00@the-village.bc.nu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 14, alan@lxorguk.ukuu.org.uk wrote:
> > This means that we need some analogue to {get,put}_unnamed_dev that
> > manages a range of dynamically allocated majors.
> > Is there such a beast already, or does someone need to write it?
> > What range(s) should be used for block devices? 
> > 
> > Am I missing something obvious here?
> 
> Obvious question: Do you need your majors to be together in order, or can
> you pick 8 random numbers each boot and expect the user to cope ?
> 
> Equally if they were static numbers do they have to be together or scattered ?

I think you are assuming that I need multiple majors so that
potentially all 256 possibly md devices can each be partitioned.  Is
that right?

I wasn't going to be that generous.  If you want to partition md
devices, you can only partition the first 16, into upto 15 partitions each.

If you have need for more arrays or more partitions than that, then
your problem is less like a peanut, and LVM begins to look less like a
sledgehammer.

NeilBrown
