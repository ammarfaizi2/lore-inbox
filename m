Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129428AbQKTXVb>; Mon, 20 Nov 2000 18:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129625AbQKTXVV>; Mon, 20 Nov 2000 18:21:21 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:12551 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129428AbQKTXVN>; Mon, 20 Nov 2000 18:21:13 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Brian Kress <kressb@fsc-usa.com>
Date: Tue, 21 Nov 2000 09:50:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14873.43714.765769.268823@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11 crashes on boot with RAID5
In-Reply-To: message from Brian Kress on Monday November 20
In-Reply-To: <3A199124.DE66EA0B@fsc-usa.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 20, kressb@fsc-usa.com wrote:
>         Hi all.  2.4.0-test11 is crashing during bootup while
> detecting my raid5 array.  According to the EIP printed (assuming
> I did it right), that's in the function xor_block().
>         2.4.0-test10 works fine with the same .config.  One of the
> things in the change file for test11 is "make raid 5 work in himem
> configs".  Maybe that broke non himem configs?
>         My .config is attached.  If anyone needs anymore information,
> let me know.

To fix:


- in drivers/md/Makefile

- find line that contains:
    raid5.o xor.o

- swap the .o files to:
    xor.o raid5.o

- recompile
- reboot
- be happy

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
