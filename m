Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130536AbRAVWbO>; Mon, 22 Jan 2001 17:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130069AbRAVWbE>; Mon, 22 Jan 2001 17:31:04 -0500
Received: from postfix.conectiva.com.br ([200.250.58.155]:47890 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129692AbRAVWa4>; Mon, 22 Jan 2001 17:30:56 -0500
Message-ID: <3A6CB49E.75B8937D@conectiva.com.br>
Date: Mon, 22 Jan 2001 20:30:54 -0200
From: Andrew Clausen <clausen@conectiva.com.br>
Organization: Conectiva
X-Mailer: Mozilla 4.76 [pt_BR] (X11; U; Linux 2.2.17-14cl i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, bug-parted@gnu.org,
        linux-kernel@vger.kernel.org
Subject: Re: Partition IDs in the New World TM
In-Reply-To: <200101222139.f0MLd8r01730@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Andrew Clausen writes:
> > But, for "well behaved operating systems", can't we do it this way?
> > (For the dos partition table scheme, 0x83 could be our "file system
> > type", 0x82 our "swap type", or whatever)
> 
> I think you're complaining about the partition IDs in this thread, and not
> the partition "schemes" that Linux supports.  Am I right?

Well, I don't like either, hehe.  But, partition IDs are the only
thing I'm talking about here (the other was merely drive-by flaming)

> Well, the Linux kernel doesn't really care about partition IDs at all,
> except in one circumstance - to detect auto RAID partitions.

Why is this necessary?  Can't the RAID drivers probe the device for
signatures, the same way file systems do?

(BTW: LVM does this too, and linux-ppc uses partition types as
heuristics
for finding the root device, IIRC, and lots of other boring stuff.  But,
I suspect it isn't needed)

> Apart from
> that, the kernel couldn't care.  You could set all your Ext2 partitions
> as ID 82, your swap as ID 83 and Linux would carry on as if nothing had
> changed.

Exactly.  So, for new disk labels, or whatever, we should recommend to
the relevant hackers that we have exactly one number for Linux.  Or
what?

> About the only user programs that know about partition IDs are:
> - fdisk (its part of the partition table format)
> - installers (to stop users doing stupid things)

Exactly.

Andrew Clausen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
