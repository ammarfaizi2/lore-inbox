Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276707AbRJGWdp>; Sun, 7 Oct 2001 18:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276708AbRJGWdg>; Sun, 7 Oct 2001 18:33:36 -0400
Received: from cs181196.pp.htv.fi ([213.243.181.196]:42629 "EHLO
	cs181196.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S276707AbRJGWdY>; Sun, 7 Oct 2001 18:33:24 -0400
Message-ID: <3BC0D83D.5E8648FC@welho.com>
Date: Mon, 08 Oct 2001 01:33:33 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: george anzinger <george@mvista.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
In-Reply-To: <Pine.LNX.4.40.0110071528040.7209-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> On Mon, 8 Oct 2001, Mika Liljeberg wrote:
> 
> > How the balance is determined is another issue, though. I basically
> > proposed summing the time slices consumed by tasks executing on a single
> > CPU and using that as the comparison value. Davide Libenzi, on the other
> > hand, simply proposed using the number of tasks.
> 
> CPU based number of __running__ tasks.

That's what I meant, sorry for not making it clear.

I suppose in practise this would amount to using the number of _CPU
bound_ running tasks per CPU, since the non-CPU bound tasks would likely
be waiting rather than running? This would then be essentially
equivalent to (and simpler than) my proposal, i.e. using the sum of the
time slices.

> - Davide

	MikaL
