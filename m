Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267516AbRG2Cvg>; Sat, 28 Jul 2001 22:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267517AbRG2Cv0>; Sat, 28 Jul 2001 22:51:26 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:47120 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S267516AbRG2CvZ>; Sat, 28 Jul 2001 22:51:25 -0400
Date: Sat, 28 Jul 2001 19:51:32 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010728195132.M30957@bluemug.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010729011552.B9350@emma1.emma.line.org> <Pine.LNX.4.33L.0107282046560.11893-100000@imladris.rielhome.conectiva> <20010729020812.D9350@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010729020812.D9350@emma1.emma.line.org>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 29, 2001 at 02:08:12AM +0200, Matthias Andree wrote:
> On Sat, 28 Jul 2001, Rik van Riel wrote:
> 
> > As Linus said, fsync() on the directory.
> 
> Relying on that to work on other operating systems is no better than
> demanding synchronous meta data writes: relying on undocumented
> behaviour.

You are blurring the boundaries between "undocumented behavior" and
"OS-specific behavior".  fsync() on a directory to sync metadata is a
defined (according to my copy of fsync(2)), Linux-specific behavior.
It is also very reasonable IMHO and in keeping with the traditional
Unix notion of directories as lists of files.

I argue that using defined Linux behavior to implement what you want
on Linux systems _is_ better than relying on undocumented behavior,
and I think most people would agree.  If you don't do this you have
not really ported the software to Linux; you instead have some
standards compliant software that "kinda usually works on Linux".
You could argue that no one should localize their software to
different versions of Unix, but you would be by far in the minority.

http://www.google.com/search?q=autoconf

Writing portable Unix software has always meant some degree
of system-specific accomodation.  It's a bummer but it's life;
otherwise Unix wouldn't evolve.

miket
