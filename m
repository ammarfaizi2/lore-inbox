Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268971AbRHPXfI>; Thu, 16 Aug 2001 19:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269002AbRHPXe7>; Thu, 16 Aug 2001 19:34:59 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:45505 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S268971AbRHPXew>; Thu, 16 Aug 2001 19:34:52 -0400
Message-Id: <5.1.0.14.2.20010817002825.00b1e4e0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 17 Aug 2001 00:35:02 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.4.9 does not compile [PATCH]
Cc: phillips@bonn-fries.net (Daniel Phillips),
        davem@redhat.com (David S. Miller), tpepper@vato.org,
        f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
In-Reply-To: <E15XWKz-0006J6-00@the-village.bc.nu>
In-Reply-To: <20010816230719Z16545-1231+1256@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 00:14 17/08/2001, Alan Cox wrote:
> > > The args and semantics of min/max changed to take
> > > a type first argument,
> >
> > They did?  This three argument min is butt-ugly, not to mention a 
> completely
> > original way of expressing the idea that is very much in conflict with 
> every
> > other expression of min I have ever seen.
> >
> > What is wrong with using typeof?  If you must have a three argument min,
> > could it please be called "type_min" of similar.
>
>It also doesnt solve all the cases.

Really? Could you point out an example where using ... typeof(x) __x; 
typeof(y) __y; ... in the macros wouldn't work? - I just tried a few 
examples I thought wouldn't work (side-effects ones) but I was pleasantly 
surprised to that gcc always produced the exact same assembler output for 
both the 3 arg and the 2 arg + typeof macros.

>Basically its just ensuring everyone doing portable code has to go and 
>change all their macros to MIN and MAX instead.

Considering the patch removed all occurences of MIN/MAX with the new 3 arg 
min/max macros it wouldn't seem that this would be accepted... )-: 
Otherwise I would submit a patch to switch NTFS. I don't like this 3 arg 
construct...

Best regards,

         Anton

>Or use if statements, which with all the subtle suprises of type casting 
>is actually often a far far better idea and probably should be encouraged 
>a lot more in the kernel



-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

