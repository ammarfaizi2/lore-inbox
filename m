Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271135AbRHYUxQ>; Sat, 25 Aug 2001 16:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271147AbRHYUw4>; Sat, 25 Aug 2001 16:52:56 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:25861 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271135AbRHYUwx>;
	Sat, 25 Aug 2001 16:52:53 -0400
Date: Sat, 25 Aug 2001 17:52:47 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Marc A. Lehmann" <pcg@goof.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010825213536.D18523@cerebro.laendle>
Message-ID: <Pine.LNX.4.33L.0108251752010.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001, Marc A. Lehmann wrote:
> On Sat, Aug 25, 2001 at 08:15:44PM +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > How much disk and bandwidth can you afford. With vsftpd its certainly over
> > 1000 parallal downloads on a decent PII box
>
> exactly this is a point: my disk can do 5mb/s with almost random
> seeks, and linux indeed reads 5mb/s from it. but the userpsace process
> doing read() only ever sees 2mb/s because the kernel throes away all
> the nice pages.

The trick here is for the kernel to throw away the pages
the processes have already used and keep in memory the
data we have not yet used.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

