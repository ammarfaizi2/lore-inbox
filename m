Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263205AbRE2E6D>; Tue, 29 May 2001 00:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263208AbRE2E5x>; Tue, 29 May 2001 00:57:53 -0400
Received: from unthought.net ([212.97.129.24]:19355 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S263205AbRE2E5i>;
	Tue, 29 May 2001 00:57:38 -0400
Date: Tue, 29 May 2001 06:57:37 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: "G. Hugh Song" <ghsong@kjist.ac.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Plain 2.4.5 VM...
Message-ID: <20010529065737.E29962@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	"G. Hugh Song" <ghsong@kjist.ac.kr>, linux-kernel@vger.kernel.org
In-Reply-To: <200105290232.f4T2W9m00876@bellini.kjist.ac.kr> <20010529061039.D29962@unthought.net> <3B1329A4.E72D9D62@kjist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3B1329A4.E72D9D62@kjist.ac.kr>; from ghsong@kjist.ac.kr on Tue, May 29, 2001 at 01:46:28PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 01:46:28PM +0900, G. Hugh Song wrote:
> Jakob,
> 
> My Alpha has 2GB of physical memory.  In this case how much swap space
> should
> I assign in these days of kernel 2.4.*?  I had had trouble with 1GB of
> swap space
> before switching back to 2.2.20pre2aa1.

If you run a single mingetty and bash session, you need no swap.

If you run four 1GB processes concurrently, I would use ~5-6G of swap to be on
the safe side.

Swap is very cheap, even if measured in gigabytes. Go with the sum of the
largest process foot-prints you can imagine running on your system, and then
add some. Be generous.  It's not like unused swap space is going to slow the
system down - it's a nice extra little safety to have.   It's beyond me why
anyone would run a system with marginal swap.

On a compile box here with 392 MB physical, I have 900 MB swap. This
accomodates multiple concurrent 100-300 MB compile jobs.   Never had a problem.
Oh, and I didn't have to change my swap setup between 2.2 and 2.4.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
