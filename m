Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285671AbRLTAKh>; Wed, 19 Dec 2001 19:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285669AbRLTAK1>; Wed, 19 Dec 2001 19:10:27 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:25613 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S285663AbRLTAKU>; Wed, 19 Dec 2001 19:10:20 -0500
Date: Thu, 20 Dec 2001 01:10:09 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Robert Love <rml@tech9.net>
Cc: Martin Devera <devik@cdi.cz>, Chris Meadors <clubneon@hereintown.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: gcc 3.0.2/kernel details (-O issue)
Message-ID: <20011220001006.GA18071@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.10.10112192037490.3265-100000@luxik.cdi.cz> <1008792213.806.36.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1008792213.806.36.camel@phantasy>
User-Agent: Mutt/1.3.24i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 03:03:30PM -0500, Robert Love wrote:
> On Wed, 2001-12-19 at 14:39, Martin Devera wrote:
> > It is interesting that 2.2 can be done with -O. Also I'd expect
> > errors during compilation and not silent crash...
> 
> Well, you certainly won't get errors, because compiler optimizations
> shouldn't change expected syntax.

It doesn't change syntax, but anything lower than -O1 simply doesn't
inline functions with an "inline" attribute. The result is that the
inline functions in header files won't get inlined and the compiler
will complain about missing functions at link time (or module insert
time).

I'm actually surprised that 2.2 can be compiled with -O, AFAIK
linux-2.2 also has a lot of inline functions in headers. I know from
experience that -Os works for 2.4 kernels on ARM, I haven't tested it
with 2.2 or x86.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
