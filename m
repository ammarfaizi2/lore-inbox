Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270999AbRIFOjm>; Thu, 6 Sep 2001 10:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271006AbRIFOjc>; Thu, 6 Sep 2001 10:39:32 -0400
Received: from ns.ithnet.com ([217.64.64.10]:19212 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S270999AbRIFOjY>;
	Thu, 6 Sep 2001 10:39:24 -0400
Date: Thu, 6 Sep 2001 16:39:09 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: phillips@bonn-fries.net, riel@conectiva.com.br, jaharkes@cs.cmu.edu,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
Message-Id: <20010906163909.186b8b46.skraw@ithnet.com>
In-Reply-To: <594419049.999788509@[10.132.112.53]>
In-Reply-To: <20010906154212.442bdf7b.skraw@ithnet.com>
	<594419049.999788509@[10.132.112.53]>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Sep 2001 15:01:49 +0100 Alex Bligh - linux-kernel
<linux-kernel@alex.org.uk> wrote:

> Yes, but this is because VM system's targets & pressure calcs do not
> take into account fragmentation of the underlying physical memory.
> IE, in theory you could have half your memory free, but
> not be able to allocate a single 8k block. Nothing would cause
> cache, or InactiveDirty stuff to be written.

Which is obviously not the right way to go. I guess we agree in that.

> You yourself proved this, by switching rsize,wsize to 1k and said
> it all worked fine! (unless I misread your email).

Sorry, misunderstanding: I did not touch rsize/wsize. What I do is to lower fs
action by not letting knfsd walk through the subtrees of a mounted fs. This
leads to less allocs/frees by the fs layer which tend to fail and let knfs fail
afterwards.

> [...]
> I think what you want isn't more memory, its less
> fragmented memory.

This is one important part for sure.

> Or an underlying system which can
> cope with fragmentation.

Well, I'd rather prefer the cure than the dope :-)

Regards, Stephan

