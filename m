Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262491AbRENVAc>; Mon, 14 May 2001 17:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262490AbRENVAW>; Mon, 14 May 2001 17:00:22 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:11018 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262491AbRENVAI>; Mon, 14 May 2001 17:00:08 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 15 May 2001 06:55:01 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15104.17957.253821.765483@notabene.cse.unsw.edu.au>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <viro@math.psu.edu>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: message from Linus Torvalds on Monday May 14
In-Reply-To: <3B003EFC.61D9C16A@mandrakesoft.com>
	<Pine.LNX.4.31.0105141328020.22874-100000@penguin.transmeta.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 14, torvalds@transmeta.com wrote:
> 
> End of discussion.
> 
> 		Linus
> 

...and start of education please...

I want to create a new block device - it is a different interface to
the software-raid code that allows the arrays to be partitioned using
normal partition tables.

So I need a major number - to give to devfs_register_blkdev at least.
You don't want me to have a hardcoded one (which is fine) so I need a
dynamically allocated one - yes?

This means that we need some analogue to {get,put}_unnamed_dev that
manages a range of dynamically allocated majors.
Is there such a beast already, or does someone need to write it?
What range(s) should be used for block devices? 

Am I missing something obvious here?

NeilBrown
