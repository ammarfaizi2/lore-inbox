Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311205AbSCLOic>; Tue, 12 Mar 2002 09:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311221AbSCLOiX>; Tue, 12 Mar 2002 09:38:23 -0500
Received: from dsl-213-023-043-170.arcor-ip.net ([213.23.43.170]:63640 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311205AbSCLOiH>;
	Tue, 12 Mar 2002 09:38:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: 2.4.19pre2aa1
Date: Tue, 12 Mar 2002 15:32:44 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>,
        wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, hch@infradead.org
In-Reply-To: <20020312070645.X10413@dualathlon.random> <E16klHb-0001up-00@starship> <20020312152534.U25226@dualathlon.random>
In-Reply-To: <20020312152534.U25226@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16knKW-0001vO-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 12, 2002 03:25 pm, Andrea Arcangeli wrote:
> On Tue, Mar 12, 2002 at 01:21:35PM +0100, Daniel Phillips wrote:
> > On March 12, 2002 12:47 pm, Andrea Arcangeli wrote:
> > > If it's pure random mul will make no difference to
> > > the distribution. And the closer we're to pure random like in the
> > > wait_table hash, the less mul will help and the more important will be
> > > to just get right the two contigous pages in the same cacheline and
> > > nothing else.
> > 
> > You're ignoring the possibility (probability) of corner cases.  I'm not
> 
> The corner cases cannot go away with a mul.

Oh but they do[1].  If there's a major point you're missing it has to be that.

[1] Not entirely of course, which Bill already pointed out clearly enough.
'Go away' always means 'get less common' with respect to hash functions,
that's the best you can do.

-- 
Daniel
