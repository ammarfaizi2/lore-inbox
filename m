Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSFFXxF>; Thu, 6 Jun 2002 19:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSFFXxE>; Thu, 6 Jun 2002 19:53:04 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:61792 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313125AbSFFXxE>; Thu, 6 Jun 2002 19:53:04 -0400
Date: Fri, 7 Jun 2002 01:53:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: Panic from 2.4.19-pre9-aa2
Message-ID: <20020606235312.GF1004@dualathlon.random>
In-Reply-To: <80230000.1023396285@flay> <20020606212028.GA1004@dualathlon.random> <83910000.1023400420@flay> <20020606231521.GB1004@dualathlon.random> <103110000.1023407113@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 04:45:13PM -0700, Martin J. Bligh wrote:
> > At first glance this seems a miscompilation, a compiler bug, not bug in
> > 2.4.19pre9aa2 (this clearly explains why you're the only one reproducing
> > this weird oops). it even sounds like ksymoops is buggy, ksymoops had to
> > say c0147dad (+7d), not c0147dac and +7c (maybe you compiled ksymoops
> > with the same compiler of the kernel? If not Keith should have a look
> > here).
> >
> > What compiler are you using? Maybe 2.96?
> 
> Errm ....  Redhat 6.2 default ... egcs-2.91.66 .... time to upgrade ?? ;-) ;-)

hmm, that's a bad news, that's egcs 1.1.2, strange, it was supposed to
be safe oh well, but OTOH I'm not too surprised nobody noticed because I
doubt many people compiles with 2.4 with egcs still.

> Pah ... reinstalling these machines is a pain in the ass .... ;-)

Could you try compiling in another machine with a gcc 2.95 and see if
you can still reproduce it? If it's a race condition and a real kernel
bug it should be easily reproducible no matter the compiler.

Andrea
