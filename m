Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274450AbRITNCp>; Thu, 20 Sep 2001 09:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274474AbRITNCg>; Thu, 20 Sep 2001 09:02:36 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:43531 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S274450AbRITNCb>;
	Thu, 20 Sep 2001 09:02:31 -0400
Date: Thu, 20 Sep 2001 10:02:45 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "David S. Miller" <davem@redhat.com>
Cc: <ebiederm@xmission.com>, <alan@lxorguk.ukuu.org.uk>,
        <phillips@bonn-fries.net>, <rfuller@nsisoftware.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <20010919.145534.104033668.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0109201001120.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, David S. Miller wrote:

> My own personal feeling, after having tried to implement a much
> lighter weight scheme involving "anon areas", is that reverse maps or
> something similar should be looked at as a latch ditch effort.
>
> We are tons faster than anyone else in fork/exec/exit precisely
> because we keep track of so little state for anonymous pages.

Thinking about this some more, it would seem that the
"perfect fork()" would be one where you DON'T copy the
page tables, but only set the parent's page tables to
read-only and point the VMAs of the child at some kind
of memory objects.

For example, for file-backed VMAs we might already skip
the page table copying right now.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

