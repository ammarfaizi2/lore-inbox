Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBTJL1>; Tue, 20 Feb 2001 04:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRBTJLS>; Tue, 20 Feb 2001 04:11:18 -0500
Received: from nas24-217.wms.club-internet.fr ([213.44.53.217]:63985 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S129098AbRBTJLF>;
	Tue, 20 Feb 2001 04:11:05 -0500
Message-Id: <200102200909.KAA12190@microsoft.com>
Subject: Re: Is this the ultimate stack-smash fix?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Cc: Eric "W." Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010220021012.A1481@storm.local>
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca>  
	<m1lmr98c5t.fsf@frodo.biederman.org> <3A8ADA30.2936D3B1@sympatico.ca>  
	<m1hf1w8qea.fsf@frodo.biederman.org> <3A8BF5ED.1C12435A@colorfullife.com>  
	<m1k86s6imn.fsf@frodo.biederman.org> <20010217084330.A17398@cadcamlab.org>  
	<m1y9v4382r.fsf@frodo.biederman.org>  <20010220021012.A1481@storm.local>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution (0.8 - Preview Release)
Date: 20 Feb 2001 10:09:55 +0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 20 Feb 2001 02:10:12 +0100, Andreas Bombe a écrit :
> On Sat, Feb 17, 2001 at 09:53:48PM -0700, Eric W. Biederman wrote:
> > Peter Samuelson <peter@cadcamlab.org> writes:
> > > It also sounds like you will be
> > > breaking the extremely useful C postulate that, at the ABI level at
> > > least, arrays and pointers are equivalent.  I can't see *how* you plan
> > > to work around that one.
> > 
> > Huh?  Pointers and arrays are clearly different at the ABI level.
> > 
> > A pointer is a word that contains an address of something.
> > An array is an array.
> 
> An array is a word that contains the address of the first element.


No. Exercise 3: compile and run this:
file a.c:
char array[] = "I'm really an array";

file b.c:
extern char* array;
main() { printf("array = %s\n", array); }

... and watch it biting the dust !
in short: an array is NOT a pointer.


    Xav

