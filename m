Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277380AbRKVQaK>; Thu, 22 Nov 2001 11:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279988AbRKVQaA>; Thu, 22 Nov 2001 11:30:00 -0500
Received: from victor.ndsuk.com ([194.202.59.31]:42513 "EHLO
	tempest.chil.ndsuk.com") by vger.kernel.org with ESMTP
	id <S277380AbRKVQ3q>; Thu, 22 Nov 2001 11:29:46 -0500
Message-ID: <F128989C2E99D4119C110002A507409801C52F90@topper.hrow.ndsuk.com>
From: "Elgar, Jeremy" <JElgar@ndsuk.com>
To: linux-kernel@vger.kernel.org
Subject: RE: Swap vs No Swap.
Date: Thu, 22 Nov 2001 16:29:38 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay I agree with that it was just quite interesting to see the mem usage.
I also agree with what people have said (VM should not have a noticeable
effect on the performance of the system) but would like to check the
original posters point (that disabling swap does increases performance.)

Also Id like to say that in general ive not had problems with the VM system
(although rarely go into swap (maybe 300 Mb after doing something
particularly memory hungry)





> -----Original Message-----
> From: Ryan Cumming [mailto:bodnar42@phalynx.dhs.org]
> Sent: 22 November 2001 16:22
> To: Elgar, Jeremy
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Swap vs No Swap.
> 
> 
> On November 22, 2001 08:11, Elgar, Jeremy wrote:
> > Hum think I'm going to test this idea out tonight, quick 
> question without
> > swap at what point would the kernel stop giving memory up for cache
> > purposes. For example I noticed on Tuesday whist doing a 
> back up of a file
> > system (in-line tar cd untar) I was left with ~4 Mb left 
> having nearly the
> > rest of my 2Gb Ram used for cache.
> 
> The general idea behind VM is pretty simple: keep the most 
> frequently used 
> pages in the fastest storage possible. The tar backup pushed 
> a lot of pages 
> that looked more frequently used in to RAM, and swapped out 
> programs that 
> weren't being used at all in favour of this cache. Now that 
> the backup is 
> completed, and only a small portion of the cache you used for 
> backup is being 
> used, these unused cache pages can very easily be 'given up' 
> to be used as 
> free memory again. A VM that -doesn't care- if it's dealing 
> with program 
> pages, buffer pages, shared memory, or cache pages when 
> making swapping 
> decisions is much more robust than a VM that tries to 
> 'outsmart' itself.
> 
> -Ryan
> 
