Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314358AbSEFKyt>; Mon, 6 May 2002 06:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314361AbSEFKys>; Mon, 6 May 2002 06:54:48 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:29939 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S314358AbSEFKys>; Mon, 6 May 2002 06:54:48 -0400
Date: Mon, 6 May 2002 12:54:35 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020506105435.GA1044@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20507.1020263013@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 12:23:33AM +1000, Keith Owens wrote:
> Linus, kbuild 2.5 is ready for inclusion in the main 2.5 kernel tree.
> It is faster, better documented, easier to write build rules in, has
> better install facilities, allows separate source and object trees, can
> do concurrent builds from the same source tree and is significantly
> more accurate than the existing kernel build system.

I do not like the new(core-11) "make *config" behaviour. Now it starts
build immediately after finishing, make xconfig effectively does
make xconfig installabled. I usually cook up the .config first, and
than decide when to compile the kernel. Now i have to interrupt the
build.

"make oldconfig" is broken btw, if the .config contains something
unknown (i.e. NEW). It used to ask for possible choices before.

And the last: kbuild-2.5 (as well as kbuild-2.4) keeps to be a good
stress/benchmark-test. Just tried to "make -f Makefile-2.5 -j" on
2.4.19-pre2-ac2... And decided to reboot after 15min (i'm at work now).
:)

-alex
