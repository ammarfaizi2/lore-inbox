Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281757AbRKUOlH>; Wed, 21 Nov 2001 09:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281434AbRKUOk5>; Wed, 21 Nov 2001 09:40:57 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:365 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S281395AbRKUOkr>; Wed, 21 Nov 2001 09:40:47 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: "David S. Miller" <davem@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14 + Bug in swap_out.
In-Reply-To: <Pine.LNX.4.33L.0111211219420.1491-100000@duckman.distro.conectiva>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Nov 2001 07:21:45 -0700
In-Reply-To: <Pine.LNX.4.33L.0111211219420.1491-100000@duckman.distro.conectiva>
Message-ID: <m1d72c19xi.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On 21 Nov 2001, Eric W. Biederman wrote:
> 
> > We only hold a ref count for the duration of swap_out_mm.
> > Not for the duration of the value in swap_mm.
> 
> In that case, why can't we just take the next mm from
> init_mm and just "roll over" our mm to the back of the
> list once we're done with it ?

Sounds good to me.  Unless we have another user for that list.
 
> Removing magic is good ;)

Definitely.  Things that are locally correct are much easier
to verify and trust.  I'm satisfied for the moment that it isn't
actually broken.  But more obvious code is definitely a plus
if we can get it.

Eric
