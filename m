Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272423AbRH3TwG>; Thu, 30 Aug 2001 15:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272424AbRH3Tvz>; Thu, 30 Aug 2001 15:51:55 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:10937 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S272423AbRH3Tvg>;
	Thu, 30 Aug 2001 15:51:36 -0400
Date: Thu, 30 Aug 2001 21:51:52 +0200
From: David Weinehall <tao@acc.umu.se>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Message-ID: <20010830215151.A14715@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.33.0108300902570.7973-100000@penguin.transmeta.com> <200108301638.SAA04923@nbd.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200108301638.SAA04923@nbd.it.uc3m.es>; from ptb@it.uc3m.es on Thu, Aug 30, 2001 at 06:38:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 06:38:40PM +0200, Peter T. Breuer wrote:
> "Linus Torvalds wrote:"
> > What if the "int" happens to be negative?
> 
>    if sizeof(typeof(a)) != sizeof(typeof(b)) 
>        BUG() // sizes differ
>    const (typeof(a)) _a = ~(typeof(a))0   
>    const (typeof(b)) _b = ~(typeof(b))0   
>    if _a < 0 && _b > 0 || _a > 0 && b < 0
>        BUG() // one signed, the other unsigned
>    standard_max(a,b)

<disgusting vomit-sound>Do you really want code like that in the
kernel (yes, I know that there are code that can compete with it in
ugliness</disgusting vomit-sound>


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
