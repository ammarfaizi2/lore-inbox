Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261944AbREXNf1>; Thu, 24 May 2001 09:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261932AbREXNfR>; Thu, 24 May 2001 09:35:17 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:34314 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261924AbREXNfM>; Thu, 24 May 2001 09:35:12 -0400
Date: Thu, 24 May 2001 15:18:36 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: "peter k." <spam-goes-to-dev-null@gmx.net>
Cc: "Adrian V. Bono" <adrianb@ntsp.nec.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: patch to put IDE drives in sleep-mode after an halt
Message-ID: <20010524151836.C1477@arthur.ubicom.tudelft.nl>
In-Reply-To: <003901c0e44d$2de3ea60$093fe33e@host1> <3B0D028F.4B7FBAB0@ntsp.nec.co.jp> <005201c0e451$57f91740$093fe33e@host1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <005201c0e451$57f91740$093fe33e@host1>; from spam-goes-to-dev-null@gmx.net on Thu, May 24, 2001 at 02:59:18PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 02:59:18PM +0200, peter k. wrote:
> well, my new 40gb ones are auto-parking i think but all the other ones from
> last year aren't
> and older hardware (although 1 year isnt even old for a hd) should be
> supported by the kernel, right?

All drives with voice coils for head movement do auto park on power off
by design. Only really old drives with stepper motors (Seagate ST225
and friends, over 15 years old) don't do it, but the capacity of those
drives don't make it worthwile supporting anyway.

> plus, its really not difficult to implement spinning down the hds before
> halt anyway

It's so easy that it should be done from the init scripts instead of
from kernel. "hdparm -Y device" forces the drive to sleep mode.

>  and then the kernel
> leaves the system as clean as it was before booting ;) !!

That's a silly argument. Why should the OS leave the system clean? It's
the boot code's task to set up the system in a proper way.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
