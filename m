Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269238AbRHQAbm>; Thu, 16 Aug 2001 20:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269212AbRHQAbb>; Thu, 16 Aug 2001 20:31:31 -0400
Received: from mnh-1-02.mv.com ([207.22.10.34]:61196 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S269238AbRHQAbR>;
	Thu, 16 Aug 2001 20:31:17 -0400
Message-Id: <200108170146.UAA05171@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        phillips@bonn-fries.net (Daniel Phillips),
        davem@redhat.com (David S. Miller), tpepper@vato.org,
        f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH] 
In-Reply-To: Your message of "Fri, 17 Aug 2001 00:35:02 +0100."
             <5.1.0.14.2.20010817002825.00b1e4e0@pop.cus.cam.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 16 Aug 2001 20:46:10 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aia21@cam.ac.uk said:
> Really? Could you point out an example where using ... typeof(x) __x;
> typeof(y) __y; ... in the macros wouldn't work? - I just tried a few
> examples I thought wouldn't work (side-effects ones) but I was
> pleasantly  surprised to that gcc always produced the exact same
> assembler output for  both the 3 arg and the 2 arg + typeof macros. 

Try min(a, min(b, c)).  Look at the cpp expansion and notice all the variable
name clashes.

We went through this on #kernel one night, and Alan concocted some amazingly
gross unique identifier generators as a result.  To me, this looks like the 
best way to do this.

				Jeff

