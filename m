Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbRHJIC1>; Fri, 10 Aug 2001 04:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbRHJICR>; Fri, 10 Aug 2001 04:02:17 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:64922 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S265249AbRHJICH>; Fri, 10 Aug 2001 04:02:07 -0400
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@i.am>
Subject: Re: 2.4.8-pre7: still buffer cache problems
Message-ID: <3B7394F7.84F87BDC@i.am>
Date: Fri, 10 Aug 2001 08:01:59 GMT
To: Rik van Riel <riel@conectiva.com.br>
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: cs, en
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33L.0108091749580.1439-100000@duckman.distro.conectiva>
Mime-Version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-pre7-RTL3.0 i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Thu, 9 Aug 2001, marc heckmann wrote:
> 
> > While 2.4.8-pre7 definitely fixes the "dd if=/dev/zero
> > of=bigfile bs=1000k count=bignumber" case. The "dd if=/dev/hda
> > of=/dev/null" is still quite broken for me.
> 
> OK, there is no obvious way to do do drop-behind on
> buffer cache pages, but I think we can use a quick
> hack to make the system behave well under the presence

There is one simple way - leave some configurable number of
maximum cachable pages.

I've been having this problem for very looooong time -
and even this simple trick - like saying that disk cache could not
take more than 40MB would help a lot.

kabi

