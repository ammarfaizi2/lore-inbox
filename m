Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135819AbRDTGeG>; Fri, 20 Apr 2001 02:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135821AbRDTGdy>; Fri, 20 Apr 2001 02:33:54 -0400
Received: from CPE-61-9-150-146.vic.bigpond.net.au ([61.9.150.146]:35058 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S135819AbRDTGdg>;
	Fri, 20 Apr 2001 02:33:36 -0400
Message-ID: <3ADFD824.C666FAA5@eyal.emu.id.au>
Date: Fri, 20 Apr 2001 16:33:08 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: esr@thyrsus.com, CML2 <linux-kernel@vger.kernel.org>
Subject: Re: Dead symbol elimination, stage 1
In-Reply-To: <20010419135955.A3841@thyrsus.com> <20010419131944.A3049@thyrsus.com> <20010419184444.A3111@flint.arm.linux.org.uk> <20010419135955.A3841@thyrsus.com> <18282.987703518@redhat.com> <20010419141425.A4461@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> David Woodhouse <dwmw2@infradead.org>:
> >
> > esr@thyrsus.com said:
> > >  I read this as "I haven't fixed the problem because..."  not as
> > > "Don't fix the problem."  Please be more explicit next time so I won't
> > > step on your toes?
> >
> > "This is not a problem, please don't \"fix\" it".
> 
> But it is.  The more false positives I get in the dead-symbol reports,
> the harder it will be to spot real problems like that business in the
> ARM kernel.c file.

Eric,

I found myself in similar situations in the past, and my solution was
to establish a small file of "do not report" symbols. I then use this
file to avoid reporting problems with items that I know are being
handled or are known false positives. Yes, it is not automagic, but
it does do the job.

The file might also include private notes as to the status of each
excluded symbol.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
