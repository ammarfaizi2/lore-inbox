Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSE0LMg>; Mon, 27 May 2002 07:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSE0LMf>; Mon, 27 May 2002 07:12:35 -0400
Received: from [62.70.58.70] ([62.70.58.70]:49282 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316579AbSE0LMe> convert rfc822-to-8bit;
	Mon, 27 May 2002 07:12:34 -0400
Message-Id: <200205271112.g4RBCH103186@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] 2.4 VM sucks. Again
Date: Mon, 27 May 2002 13:12:16 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Martin.Bligh@us.ibm.com (Martin J. Bligh), linux-kernel@vger.kernel.org
In-Reply-To: <E17BGj9-0006VQ-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > How much RAM do you have, and what does /proc/meminfo
> > > and /proc/slabinfo say just before the explosion point?
> >
> > I have 1 gig - highmem (not enabled) - 900 megs.
> > for what I can see, kernel can't reclaim buffers fast enough.
> > ut looks better on -aa.
>
> What sort of setup. I can't duplicate the problem here ?

The setup is 2-4 drives in raid0, with chunk size 1MB.

If I try to do ~50 simultanous reads from disk, it's no problem as long as 
the data is being read from the nic with the same speed as it's being read 
from disk. The server apps are running via inetd (testing), and have 2MB of 
buffer each. (read 2MB from disk, write 2MB to NIC).

The server chrashes within minutes. The same problem occurs when using Tux

thanks

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.
