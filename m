Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280937AbRKGT2t>; Wed, 7 Nov 2001 14:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280939AbRKGT2m>; Wed, 7 Nov 2001 14:28:42 -0500
Received: from f57.law9.hotmail.com ([64.4.9.57]:28677 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S280933AbRKGT2Z>;
	Wed, 7 Nov 2001 14:28:25 -0500
X-Originating-IP: [128.2.152.69]
From: "William Knop" <w_knop@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Date: Wed, 07 Nov 2001 14:28:18 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F57jukJ1zkc6g9wHRQa0000b09f@hotmail.com>
X-OriginalArrivalTime: 07 Nov 2001 19:28:19.0342 (UTC) FILETIME=[5B22FAE0:01C167C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Yes, but I meant a program which reads a single binary value and >outputs 
>it as ascii, as a generic layer between the binary /proc and >the ascii 
>world of shell scripts.
>
>I don't like a binary /proc.

The binary issue could very easily be solved, as you said, by a small 
generic program to do the conversion. Upside it only shell scripts need 
this, while more advanced (lower level) programs will get better preformance 
out of binary format. Downside? I am not sure I see the problem. If a 
program needs to get a lot of /proc info frequently, a binary interface will 
be faster. Idealistically, do we want the kernel interfaces binary or ascii? 
Do we want them to preform best with (be native to) shell scripts or 
programs?

In any event, is the format of process info (actually should be in /proc) or 
the-other-stuff the issue? If it is the latter, the compatibility issue has 
a fairly easy solution...

>But I agree: /proc is populated with files that don't really belong >there. 
>Maybe everything should be moved to /kernel? (except for the
>process info, offcourse).

I like this idea a lot, and so far I haven't heard any objections, save 
compatability...

>It will be very, very hard for distributors to create a distribution >which 
>runs one the native 2.6 /proc interface as soon as 2.6 comes >out. I think 
>we must assume rewriting things like procps, init >scripts, etc. will only 
>start as soon as 2.6 comes out. We should >provide some transitional period 
>for userspace to adapt, but make >clear to everybody that compatibility 
>isn't going to last forever.

Simple solution is to move /kernel stuff of /proc to /kernel (new format, 
bin, ascii, whatever) and put transition code (old code still serving the 
old format /kernel stuff) serving in /proc. Make the backwards compatibility 
/proc a compile option. That way, userland developers will have time to 
migrate to /kernel (or whatever it should be called). Not too much effort, 
makes userland developers not sweat to death...

Will Knop
w_knop@hotmail.com

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

