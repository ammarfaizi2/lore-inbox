Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269481AbRHQCkd>; Thu, 16 Aug 2001 22:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269465AbRHQCkX>; Thu, 16 Aug 2001 22:40:23 -0400
Received: from mnh-1-07.mv.com ([207.22.10.39]:39693 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S269471AbRHQCkS>;
	Thu, 16 Aug 2001 22:40:18 -0400
Message-Id: <200108170355.WAA05758@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        phillips@bonn-fries.net (Daniel Phillips),
        davem@redhat.com (David S. Miller), tpepper@vato.org,
        f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH] 
In-Reply-To: Your message of "Fri, 17 Aug 2001 02:22:10 +0100."
             <5.1.0.14.2.20010817015007.045689b0@pop.cus.cam.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 16 Aug 2001 22:55:16 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aia21@cam.ac.uk said:
> There are no clashes; unless my knowledge of C has abandoned me at the
>  moment, you can reuse variable names within local statement blocks
> and the  compiler is intelligent enough to sort it out. 

Sorry, you're right.  I wasn't thinking this through enough.  I was thinking 
that
	min(a, min(b, c))
would cause cpp to do things like
	int __x = (__x)

It seems the only problematic case is calling it with __x type arguments.

				Jeff

