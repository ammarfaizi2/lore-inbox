Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbRFASke>; Fri, 1 Jun 2001 14:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261198AbRFASkX>; Fri, 1 Jun 2001 14:40:23 -0400
Received: from comverse-in.com ([38.150.222.2]:50908 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S261173AbRFASkF>; Fri, 1 Jun 2001 14:40:05 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678F10@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'Mark Frazer'" <mark@somanetworks.com>
Cc: "'Pete Wyckoff'" <pw@osc.edu>, Linux Kernel <linux-kernel@vger.kernel.org>,
        "'kaos@ocs.com.au'" <kaos@ocs.com.au>
Subject: RE: Makefile patch for cscope and saner Ctags
Date: Fri, 1 Jun 2001 14:39:08 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cscope:

Minor stuff:
1) in cscope.files - I'd be replacing cscope.files with $@ within the rule -
you don't need a yellow belt to know $@ within a Makefile
2) /bin/rm vs rm

tags: Not going deep into it, I possibly should say here that hardwiring
depth 5 is not the best thing probably - once someone extends down to 6,
this place in the Makefile will for sure not be updated. You can make a loop
here to max depth, which you can discover right here, rather than the
current manually unrolled loop.

In general, I am not a tags user in the kernel (sticking to local tags +
global cscope), so I'd be happy if you and 
Pete could merge together your tags stuff. As for the ignore list, I don't
see much of maintenance work there - and, if you guys think there is, maybe
it is just possible to add Pete on the Kernel Build maintainers WRT to that
file?

Overall, IMHO, after you give it the last touch (maybe just dismissing my
present letter :-) ) the cscope stuff is mature enough for going to KO & Co.
(i.e. the kernel build guys); I don't consider myself a hardcore tags user
to say so about the tags portion. 

Keith, what do you think?

Vassilii

> -----Original Message-----
> From: Mark Frazer [mailto:mark@somanetworks.com]
> Sent: Thursday, May 31, 2001 4:45 PM
> To: Khachaturov, Vassilii
> Cc: Linux Kernel
> Subject: Re: Makefile patch for cscope and saner Ctags
> 
> 
> Khachaturov, Vassilii <Vassilii.Khachaturov@comverse.com> 
> [01/05/31 15:00]:
> > Don't forget to bug RH package maintainer on that. Whatever 
> 
> bugzilla submitted
> 
> > I use source-built cscope v.15.1, and -k works for me here, 
> 
> works for me too!
> 
> > WHY?! Isn't it better to put $(shell cat cscope.files) on 
> the list of
> 
> I only have a yellow belt in makefile kungfu.  These fancy 
> gnu make things
> are relatively new to some of us...
> 
> The latest patch is attached.  include/linux/compile.h seems to get
> built whenever I run make, so that's why I've excluded it 
> from the deps
> for cscope.out.
> 
