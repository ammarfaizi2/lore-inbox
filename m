Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286616AbRLUWye>; Fri, 21 Dec 2001 17:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286617AbRLUWyZ>; Fri, 21 Dec 2001 17:54:25 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:25656 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S286616AbRLUWyN>; Fri, 21 Dec 2001 17:54:13 -0500
Message-Id: <4.3.2.7.2.20011221140707.00c0e290@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 21 Dec 2001 14:53:50 -0800
To: Rik van Riel <riel@conectiva.com.br>, "Eric S. Raymond" <esr@thyrsus.com>
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Re: Configure.help editorial policy
Cc: David Garfield <garfield@irving.iisd.sra.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0112211913360.28489-100000@duckman.distro.c
 onectiva>
In-Reply-To: <20011221134034.B11147@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:17 PM 12/21/01 -0200, Rik van Riel wrote:
>As a last point, we shouldn't forget about the inconsistent
>way in which the marketing departments of hardware vendors
>apply these units to their products. In many cases binary
>and decimal units are mixed, leading to something which is
>impossible to "get right".  Disk space would be one example
>of this, but I'm sure there are more.
>
>regards,
>
>Rik

OK, how about this silly suggestion:  DON'T USE ABBREVIATIONS IN DOCUMENTATION.

For example, let me propose an "edit" to the text that has been appearing 
in this thread to eliminate the ambiguity:

 > # Choice: himem
 > High Memory support
 > CONFIG_NOHIGHMEM
 >   Linux can use up to 64 * 2^30 bytes (64 gigabytes) of physical memory 
on x86 systems.
 >   However, the address space of 32-bit x86 processors is only 4 * 2^30 
bytes (four gigabytes)
 >   large. That means that, if you have a large amount of
 >   physical memory, not all of it can be "permanently mapped" by the
 >   kernel. The physical memory that's not permanently mapped is called
 >   "high memory".
 >
 >   If you are compiling a kernel which will never run on a machine with
 >   more than 960 * 2^20 bytes (960 megabytes) of total physical RAM, 
answer "off" here
 >   (default choice and suitable for most users). This will result in a
 >   3:1 split: each process sees a 3 * 2^30 byte (three gigabyte)
 >   virtual memory space, and the remaining 1 * 2^30 (one gigabyte) 
of  virtual memory
 >   space is used by the kernel to permanently map as much physical memory
 >   as possible.
 >
 >   If the machine has between one 2^30 bytes and four 2^30 bytes of 
physical RAM, then
 >   answer "4GB" here.

In this edit, the only place where the abbreviation "GB" appears is in the 
symbol definition space.  Configuration symbols are by custom all 
upper-case, so the standard for capitalization as specified in SI is 
violated in the interest of a symbol space that is consistent.

What kills me is that people forget the origin of KB as a standard 
designation for "kilobyte" in the first place.  Does anyone remember the 
KSR-33 teletype, the early dot-matrix printers, and other output devices 
that output only upper-case characters?  Maybe you youngsters don't recall 
that lower-case character devices were EXPENSIVE -- I still have a TI 
Silent 700 terminal that did output lower-case when connected to systems 
that understood the full ASCII alphabet, but those systems were few and far 
between in business applications -- upper-case-only was "good enough."  How 
about tab machines that never did have lower-case, such as the 407 printing 
accounting machine?

It got worse when you need to differentiate between "bytes" and "bits" 
because you didn't have the luxury of using "B" for "byte" and "b" for 
"bit" -- so that's why you see in legacy documentation a lone "K" for 
"kilobit".

Have you noticed that some schematic packages *still* don't support lower 
case for all output devices?

So now you know where the common usage of K, KB, MB, GB and the rest came 
from -- limitations in the early tools for doing electronic documentation 
of computer systems.  Now, some of you may scream that we no longer have 
those limitations -- but what are you going to do with the vast body of 
written knowledge that is written using the accepted abbreviations of the 
time?  Unless someone is going to go back and re-edit 30 years of academic 
papers, journal articles, and legacy documentation of equipment already in 
use (can you say telephone systems?) then any argument about re-doing 
abbreviations "for esthetic reasons" is either pointless or yet another 
cause for confusion.  Especially as this has every stigmata of becoming a 
religious war.

So here we are, campers, arguing about abbreviations when in fact there is 
no real NEED for abbreviations outside of the config symbol space.  Why not 
just take the few extra bytes (they are not a penny each anymore) to spell 
out what you really mean?  Why do we need MB or mB or MiB for 
"megabyte"?  Sometimes we get so wrapped up in our abbreviations that we 
lose sight of the fact that the original job of a HELP FILE is to HELP, to 
COMMUNICATE really useful information to the person trying to configure 
their Linux kernel to a specific purpose.  Don't forget that the audience 
for configure.help goes far beyond the 30K of us (oops, I used an 
abbreviation -- sorry) that work with this sort of stuff on a continuing 
basis -- members of the priesthood, if you will.  What would your mother or 
grandmother say if confronted with this sort of stuff?  Is it necessary to 
obfuscate your meaning to the unwashed?  (Even my edit caters to the expert 
to some extent -- I admit it.)

Frankly, if the reason you use abbreviations is because you type slowly, I 
can't feel any pain for you.  There are lots of courses, sources, and even 
gaming software around the world designed to teach you to type on a QWERTY 
keyboard, far too many for me to feel any pain at all about your lack -- if 
you are too lazy to learn a necessary skill for your craft or hobby, then 
you might want to think about finding another career or passtime.

Oh, before someone quotes my Slashdot interview and says "Hey, it's easy 
for you, you are a professional writer" I'll tell you that my high school 
summer-school typing course increased my keypunching productivity by a 
factor of 15 while I was still a hobbyist, and permitted me to make full 
use of that KSR-33 and glass TTY and so forth as a professional...and that 
I was a programmer for 12 years before I wrote my first article for 
money.  (I hope none of you EVER see that first article, which thank the 
deity of your choice never saw publication.)

Look, I'm sorry if this comes across as harsh, but I can't believe you 
people WANT to alienate users for the sake of an obscurity.  Please 
CONSIDER YOUR AUDIENCE -- ALL of them.  Not just the top one-half of one 
percent.  The worst sin any writer -- professional or amateur, technical or 
popular, fiction or non-fiction -- can do is lose the reader.  And that, 
people, is what you are doing with this debate.

Stephen Satchell

