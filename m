Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132865AbQL3SJy>; Sat, 30 Dec 2000 13:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133087AbQL3SJp>; Sat, 30 Dec 2000 13:09:45 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:37903 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S132865AbQL3SJd>; Sat, 30 Dec 2000 13:09:33 -0500
Date: Sat, 30 Dec 2000 18:38:38 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.18: /proc/apm slows system time (was: Linux 2.2.19pre3)
Message-ID: <20001230183837.C1536@arthur.ubicom.tudelft.nl>
In-Reply-To: <20001230133910.A5341@emma1.emma.line.org> <E14CPNo-0006ny-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14CPNo-0006ny-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Dec 30, 2000 at 05:01:27PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2000 at 05:01:27PM +0000, Alan Cox wrote:
> Looking at the one laptop with this problem I could acquire access to it seems
> that the box switches to SMM mode with interrupts disabled for several timer
> ticks. During this time the i2c bus is active and it appears to be having a
> slow polled conversation with the battery or something attached to the battery
> and monitoring it.

Sounds like a good explanation.

> Doing
> 
> 	while { true }
> 	do
> 		cat /proc/apm
> 	done
> 
> made the box visibly stall and jerk doing X operations

Yup, same over here. Is there any way to find out if my laptop also
enters SMM mode? Just to check if it has the same problem as your
laptop.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
