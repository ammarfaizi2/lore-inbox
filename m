Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266586AbRGGVei>; Sat, 7 Jul 2001 17:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266582AbRGGVeS>; Sat, 7 Jul 2001 17:34:18 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:20715 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266588AbRGGVeG>;
	Sat, 7 Jul 2001 17:34:06 -0400
Message-ID: <3B47804C.77B7329A@mandrakesoft.com>
Date: Sat, 07 Jul 2001 17:34:04 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33L.0107071828500.1389-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Sat, 7 Jul 2001, Alan Cox wrote:
> 
> > > instead. That way the vmstat output might be more useful, although vmstat
> > > obviously won't know about the new "SwapCache:" field..
> > >
> > > Can you try that, and see if something else stands out once the misleading
> > > accounting is taken care of?
> >
> > Its certainly misleading. I got Jeff to try making oom return
> > 4999 out of 5000 times regardless.
> 
> In that case, he _is_ OOM.  ;)
> 
> 1) (almost) no free memory
> 2) no free swap
> 3) very little pagecache + buffer cache

It got -considerably- farther after Alan's suggested hack to the OOM
killer; so at least in this instance, OOM killer appeared to me to be
killing too early...

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
