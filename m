Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262583AbRFCK2y>; Sun, 3 Jun 2001 06:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262616AbRFCK2o>; Sun, 3 Jun 2001 06:28:44 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:16144 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S262583AbRFCK2k>; Sun, 3 Jun 2001 06:28:40 -0400
Date: Sun, 3 Jun 2001 12:24:09 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compile problem with ov511.c (Kernel 2.4.5)
Message-ID: <20010603122409.D27260@arthur.ubicom.tudelft.nl>
In-Reply-To: <3B19E4D0.885C50CA@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B19E4D0.885C50CA@candelatech.com>; from greearb@candelatech.com on Sun, Jun 03, 2001 at 12:18:40AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 03, 2001 at 12:18:40AM -0700, Ben Greear wrote:
> gcc -D__KERNEL__ -I/home/greear/kernel/2.4/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686
> -DMODULE -DMODVERSIONS -include /home/greear/kernel/2.4/linux/include/linux/modversions.h   -c -o ov511.o ov511.c
> ov511.c: In function `ov511_read_proc':
> ov511.c:340: `version' undeclared (first use in this function)
> ov511.c:340: (Each undeclared identifier is reported only once
> ov511.c:340: for each function it appears in.)
> make[2]: *** [ov511.o] Error 1
> make[2]: Leaving directory `/home/greear/kernel/2.4/linux/drivers/usb'
> make[1]: *** [_modsubdir_usb] Error 2
> make[1]: Leaving directory `/home/greear/kernel/2.4/linux/drivers'
> make: *** [_mod_drivers] Error 2

Try this patch:

    http://boudicca.tux.org/hypermail/linux-kernel/2001week21/1010.html

Or use 2.4.5-ac*.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
