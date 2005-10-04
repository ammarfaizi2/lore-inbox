Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVJDFDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVJDFDX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 01:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVJDFDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 01:03:22 -0400
Received: from web35513.mail.mud.yahoo.com ([66.163.179.137]:20404 "HELO
	web35513.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751184AbVJDFDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 01:03:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=LMPwz7YrAEumzFQqBLrj36ycqTMxPo1WVEtplwMdkvVgVywJxPT2/abPEZKGaLCxd6xDpWjB1pnMKGmlad2ERLorpejbRLT47fC9kgxeMeFntoZYzggZbiHSq68WFdZ5ab3is/aN7joDyAkIEj5vKB/rk4lUJCgbv8HJ2EwyCIY=  ;
Message-ID: <20051004050321.21353.qmail@web35513.mail.mud.yahoo.com>
Date: Mon, 3 Oct 2005 22:03:21 -0700 (PDT)
From: Dan C Marinescu <dan_c_marinescu@yahoo.com>
Subject: Re: The price of SELinux (CPU)
To: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
In-Reply-To: <434204F8.2030209@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Don't buy that 7% increased CPU (can easily verify
it...)  start the kernel with selinux=0 (totally
disable selinux) and compare the results for
yourself...

Now about big_o... In two words, big O is a way of
describing the performance of an algorithm. If a
system has 2 deal with n steps it is said to be:
*constant O(1) if n doesn't affect the total run_time
of that system (eats the same amount of time
regardless n). O(n) is called linear (total
computation time is a linear dependency of n, that is
if it took 3 secs when n = 3, it would take 11 secs
when n = 11. And so on... (detail: in case of a
polinomial, only the highest power matters!) of
course, the lower the better! I have __big__ doubts
that NSA implemented something higher than linear...
(I suspect that their folks go from O(1) to O(ln(n))
// quality work... Anyway, if O(n) is somehow
acceptable for certain algorithms, O(n to power 2, 3,
n) are to be avoided at all cost! (see the widowz
“kernel” live example of quadratic micro-kernels ;-)

*** The perfect case is not (yet) defined in general
theory of computation. That would be O(0) when a
system performs an infinite number of elementary
computations in ZERO seconds :-) 
*** Same about O(infinite) // obviously the worst
case, when a (super lazy) system needs an eternity to
do... nothing! :-) // see frequent blue screens on
costco purchased personal computers :-)

The smartest the author, the lower the O! In user_land
O(n) is considered acceptable in most cases...

So, in two words, simply put, fast is good :-) && slow
is bad :-(


   Daniel


--- John Richard Moser <nigelenki@comcast.net> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I've heard that SELinux has produced benchmarks such
> as 7% increased CPU
> load.  Is this true and current?  Is it dependent on
> policy?  What is
> the policy lookup complexity ( O(1), O(n),
> O(nlogn)...)?  Are there
> other places where a bottleneck may exist aside from
> gruffing with the
> policy?  Isn't the policy actually in xattrs so it's
> O(1)?  Where else
> would an overhead that big come from aside from a
> lookup in a table?
> 
> ....
> 
> Why is the sky blue?  Why do you have a mustach? 
> Why doesn't mommy have
> one?  Does she shave it?
> 
> At any rate, my personal end goal is a secure
> high-performance operating
> system, as user friendly as Ubuntu, Mandriva, or
> Win----.  To this end,
> I'm (still; a lot of you have seen me before)
> evaluating the performance
> hit of various user and kernel security enhancements
> like PaX,
> ProPolice, various OpenWall/GrSecurity niceness that
> needs to be divided
> out, and of course LSM/SELinux.  Also wondering
> about that PHKMalloc
> thing on openbsd; is it really all that, is it junk,
> how's it compare to
> the recent ptmalloc work, and can it run on Linux
> for direct benching .
> . . but that's off topic.
> 
> - --
> All content of all messages exchanged herein are
> left in the
> Public Domain, unless otherwise explicitly stated.
> 
>     Creative brains are a valuable, limited
> resource. They shouldn't be
>     wasted on re-inventing the wheel when there are
> so many fascinating
>     new problems waiting out there.
>                                                  --
> Eric Steven Raymond
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.1 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird -
> http://enigmail.mozdev.org
> 
>
iD8DBQFDQgT4hDd4aOud5P8RAoWBAJ0foEe4JcqDDlb7mMXQ6Z6FjCFjLACfdmJz
> +j2lCH7DpTlZK6zUztldEGI=
> =RzhA
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
