Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319053AbSHSUSB>; Mon, 19 Aug 2002 16:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319054AbSHSUSA>; Mon, 19 Aug 2002 16:18:00 -0400
Received: from dsl-213-023-038-214.arcor-ip.net ([213.23.38.214]:39556 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319053AbSHSUR6>;
	Mon, 19 Aug 2002 16:17:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] rmap bugfix, try_to_unmap
Date: Mon, 19 Aug 2002 22:23:39 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
       Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
References: <Pine.LNX.4.44L.0208191715130.1857-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0208191715130.1857-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17gt3r-0000rb-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 August 2002 22:15, Rik van Riel wrote:
> On Mon, 19 Aug 2002, Daniel Phillips wrote:
> > On Monday 12 August 2002 16:58, Rik van Riel wrote:
> > >  	case SWAP_FAIL:
> > >  		ret = SWAP_FAIL;
> > > -		break;
> > > +		goto give_up;
> >
> > Yes, I looked at that many times while reading the break as a 'break
> > from loop' every time.  Using the same keyword to mean 'stop looping'
> > and 'endcase' was, by any measure, a stupid idea.
> 
> What's even more curious is that 'continue' has the exact
> same effect on 'switch' ...

Come to think of it, what you want there is:

 	case SWAP_FAIL:
  		return SWAP_FAIL;

-- 
Daniel
