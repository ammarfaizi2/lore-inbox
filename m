Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQLaQVu>; Sun, 31 Dec 2000 11:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130107AbQLaQVk>; Sun, 31 Dec 2000 11:21:40 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:41996 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129401AbQLaQVf>; Sun, 31 Dec 2000 11:21:35 -0500
Date: Sun, 31 Dec 2000 16:50:58 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.18: /proc/apm slows system time (was: Linux 2.2.19pre3)
Message-ID: <20001231165058.H940@arthur.ubicom.tudelft.nl>
In-Reply-To: <20001231113423.A5146@emma1.emma.line.org> <E14CifW-000818-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14CifW-000818-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Dec 31, 2000 at 01:37:00PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2000 at 01:37:00PM +0000, Alan Cox wrote:
> Nothing much
> 
> > Is there at least away we can recover the proper system time after these
> > stalls?
> 
> If you have a tsc on your chip - I think most modern laptops will do as they
> tend to be pentium/mmx k6 or pII/pIII processors, then you can check the 
> elapsed CPU cycles and recover the jiffies from that. Might be an interesting
> exercise for someone

But that doesn't solve the problem with corrupted sound, serial drop
outs, etc. To solve those issues (well, to decrease their impact),
could we cache the results from a previous call and only call the APM
BIOS once a minute or so?


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
