Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbTAJRpe>; Fri, 10 Jan 2003 12:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbTAJRpe>; Fri, 10 Jan 2003 12:45:34 -0500
Received: from pc132.utati.net ([216.143.22.132]:47757 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S265791AbTAJRpd> convert rfc822-to-8bit; Fri, 10 Jan 2003 12:45:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.53 with contest
Date: Fri, 10 Jan 2003 17:54:26 +0000
User-Agent: KMail/1.4.3
References: <200212261038.04015.conman@kolivas.net> <200301071944.18098.landley@trommello.org> <200301090732.24440.conman@kolivas.net>
In-Reply-To: <200301090732.24440.conman@kolivas.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301101754.26216.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 January 2003 20:32, Con Kolivas wrote:

> > Could you add a time per load metric?  (I.E. 86.9/21=4.14 seconds.  Yeah,
> > I could do the math myself, but that and total time are usually what I'm
> > trying to compare when I look at these.  Maybe it's just me...)
>
> If you look at the information carefully the meaningful number is
>
> (Loads ) / ( process_load_time - no_load_time)

Hmmm...  Have to think about this a sec...

So far I've just been looking at the deltas between versions,  like I said, 
with the implicit assumption that no_load_time remains roughly constant 
(after all, kernel build time is what everybody's been optimizing for since 
the 2.0 era).

There are really two things it would be nice to isolate: one is the amount of 
thrashing the extra processing introduces, slowing down the whole system.  
The other is the balancing decisions that are made (the amount of work done 
by io_load or mem_load varies and has no impact on the termination of the 
test as a whole...)  I sort of want to isolate out the balancing decisions a 
bit, or at least have a metric to look at them and compare them.  (I.E. "yeah 
it got slower, but it did more work overall".  Now is this what everybody 
WANTS, and could we maybe twiddle this with precedence in the scheduler or 
something if it isn't?)

I suppose your metric is a more accurate way of measuring that.  Cool.

> but keep an eye out for a new version soon.
>
> Con

Of course, :)

Rob

-- 
penguicon.sf.net - A combination Linux Expo and Science Fiction Convention 
with GOHs Terry Pratchett, Eric Raymond, Pete Abrams, Illiad & CmdrTaco.
