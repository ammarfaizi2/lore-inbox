Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286699AbSABEZb>; Tue, 1 Jan 2002 23:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286710AbSABEZW>; Tue, 1 Jan 2002 23:25:22 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:21919 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S286699AbSABEZG>; Tue, 1 Jan 2002 23:25:06 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Manfred Spraul <manfred@colorfullife.com>
Date: Wed, 2 Jan 2002 15:26:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15410.35800.154586.201540@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] event cleanup, part 2
In-Reply-To: message from Manfred Spraul on Tuesday January 1
In-Reply-To: <3C32260E.CEADDF59@colorfullife.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday January 1, manfred@colorfullife.com wrote:
> Linus merged the first part of my patches that remove
> 'event' into 2.5.2-pre3.
> 
> Attached is the second patch.
> 
> patch 1: remove all event users except readdir().
> 	Merged.

Not quite.  ext2 and ext3 (At least) use event to set i_generation to
a pseudo-random number, and that still seems to be so in 2.5.2-pre6.
What do you plan to do with that usage of event?
Possibly replacing it with net_random or similar would be fine.

NeilBrown
