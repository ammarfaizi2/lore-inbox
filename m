Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278073AbRJZJVt>; Fri, 26 Oct 2001 05:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278076AbRJZJV3>; Fri, 26 Oct 2001 05:21:29 -0400
Received: from [213.237.118.153] ([213.237.118.153]:19584 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S278073AbRJZJVT>;
	Fri, 26 Oct 2001 05:21:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel compiler
Date: Fri, 26 Oct 2001 11:18:46 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <E15wmgp-0005E8-00@the-village.bc.nu> <3BD841B7.5060405@toughguy.net> <20011026001354.C2245@werewolf.able.es>
In-Reply-To: <20011026001354.C2245@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15x38c-0000Dh-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 October 2001 00:13, J . A . Magallon wrote:
> On 20011025 Lost Logic wrote:
> >GCC 3.0 Produces slower code, eh?  I was of the understanding that it
> >contained many more optimizations than previous versions...???
> >
> >Any way, I've been able to run my system based entirely on a fairly
> >recent GCC CVS-3.02 snapshot, including kernels, and everything EXCEPT
> >for glibc which is specifically incompatible according to the GNU folks.
> >
> >By way of information however, neither of the GCC 3.0 releases (3.0.0 or
> >3.0.1) work at all on my system, and I cannot get a kernel to function
> >at better than -O2 (not that I could get that to work in 2.95.* or
> >2.96.* either).
>
> -O3 activates -finline-functions:
> `-finline-functions'
>      Integrate all simple functions into their callers.  The compiler
>      heuristically decides which functions are simple enough to be worth
>      integrating in this way.
>
>      If all calls to a given function are integrated, and the function
>      is declared `static', then the function is normally not output as
>      assembler code in its own right.
>
> Last paragraph is the key. Perhaps previous gcc'd did not all his work
> as the manual says (ie, did not kill the non-inline version, bug),
> but people has got used to the bug, and see it as a feature.

I believe '-fkeep-inline-functions' is your friend in this case. I haven't 
tested it though on the kernel.

regards
`Allan

