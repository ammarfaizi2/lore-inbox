Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131873AbRCYMVb>; Sun, 25 Mar 2001 07:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131958AbRCYMVU>; Sun, 25 Mar 2001 07:21:20 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:31494 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131873AbRCYMVJ>; Sun, 25 Mar 2001 07:21:09 -0500
Date: 25 Mar 2001 13:44:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <7yXNer9Xw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.31.0103231159300.766-100000@penguin.transmeta.com>
Subject: Re: Version 6.1.8 of the aic7xxx driver availalbe
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.31.0103231159300.766-100000@penguin.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 23.03.01 in <Pine.LNX.4.31.0103231159300.766-100000@penguin.transmeta.com>:

> On Thu, 22 Mar 2001, Justin T. Gibbs wrote:
> >
> > 	aic7xxx_proc.c:
> > 		Use an unsigned long for total number of commands
> > 		sent to a device.  %q and %lld don't seem to work
> > 		under Linux or I'd have used a uint64_t.
>
> It's "%Ld".
>
> Think ANSI "long long double" -> "Lf".
>
> Thus "long long int" -> "Ld".
>
> I know it's at least been discussed for ANSI C9X, although I have no idea
> if it actually caught on.

It went the other way:

ISO/IEC 9899:1999 (E) +ISO/IEC:

7 The length modifiers and their meanings are:

hh Specifies that a following d, i, o, u, x,or X conversion specifier  
applies to a signed char or unsigned char argument (the argument will have  
been promoted according to the integer promotions, but its value shall be  
converted to signed char or unsigned char before printing); or that a  
following n conversion specifier applies to a pointer to a signed char  
argument.

h Specifies that a following d, i, o, u, x,orX conversion specifier  
applies to a short int or unsigned short int argument (the argument will  
have been promoted according to the integer promotions, but its value  
shall be converted to short int or unsigned short int before printing); or  
that a following n conversion specifier applies to a pointer to a short  
int argument.

l (ell) Specifies that a following d, i, o, u, x,orX conversion specifier  
applies to a long int or unsigned long int argument; that a following n  
conversion specifier applies to a pointer to a long int argument; that a  
following c conversion specifier applies to a wint_t argument; that a  
following s conversion specifier applies to a pointer to a wchar_t  
argument; or has no effect on a following a, A, e, E, f, F, g, or G  
conversion specifier.

ll (ell-ell) Specifies that a following d, i, o, u, x,orX conversion  
specifier applies to a long long int or unsigned long long int argument;  
or that a following n conversion specifier applies to a pointer to a long  
long int argument.

j Specifies that a following d, i, o, u, x,orX conversion specifier  
applies to an intmax_t or uintmax_t argument; or that a following n  
conversion specifier applies to a pointer to an intmax_t argument.

z Specifies that a following d, i, o, u, x,orX conversion specifier  
applies to a size_t or the corresponding signed integer type argument; or  
that a following n conversion specifier applies to a pointer to a signed  
integer type corresponding to size_t argument.

t Specifies that a following d, i, o, u, x,orX conversion specifier  
applies to a ptrdiff_t or the corresponding unsigned integer type  
argument; or that a following n conversion specifier applies to a pointer  
to a ptrdiff_t argument.

L Specifies that a following a, A, e, E, f, F, g,orG conversion specifier applies to a long double argument. If a length modifier appears with any conversion specifier other than as specified above, the behavior is undefined.




MfG Kai
