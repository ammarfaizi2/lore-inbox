Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281772AbRKUMRs>; Wed, 21 Nov 2001 07:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281763AbRKUMR1>; Wed, 21 Nov 2001 07:17:27 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:55052 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281758AbRKUMRS>;
	Wed, 21 Nov 2001 07:17:18 -0500
Date: Wed, 21 Nov 2001 10:17:07 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "David S. Miller" <davem@redhat.com>, <torvalds@transmeta.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14 + Bug in swap_out.
In-Reply-To: <m1lmh01vg0.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33L.0111211016270.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Nov 2001, Eric W. Biederman wrote:
> "David S. Miller" <davem@redhat.com> writes:
>
> > I do not agree with your analysis.
>
> Neither do I now but not for your reasons :)
>
> I looked again we are o.k. but just barely.  mmput explicitly checks
> to see if it is freeing the swap_mm, and fixes if we are.  It is a
> nasty interplay with the swap_mm global, but the code is correct.

To be honest I don't see the reason for this subtle
playing with swap_mm in mmput(), since the refcounting
should mean we're safe.

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

