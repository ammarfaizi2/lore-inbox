Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136073AbREJMUT>; Thu, 10 May 2001 08:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136111AbREJMUJ>; Thu, 10 May 2001 08:20:09 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:10961 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S136073AbREJMTu>; Thu, 10 May 2001 08:19:50 -0400
Date: Thu, 10 May 2001 14:19:48 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Helge Hafting <helgehaf@idb.hist.no>
Cc: "J . A . Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
Message-ID: <20010510141948.T754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.33.0105070823060.24073-100000@svea.tellus> <3AF663F1.E04D90CE@idb.hist.no> <20010507210229.A7724@werewolf.able.es> <3AF7A5AF.789AC083@idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3AF7A5AF.789AC083@idb.hist.no>; from helgehaf@idb.hist.no on Tue, May 08, 2001 at 09:52:15AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2001 at 09:52:15AM +0200, Helge Hafting wrote:
> > Isn't this asking for trouble with the optimizer ? It could kill both
> > !!. Using that is like trusting on a certain struct padding-alignment.
> 
> No, this won't cause trouble with the optimizer, because the
> optimizer isn't supposed to do _wrong_ things.
 
Right. The optimizer proves equivalence of terms and exchange the
one that are bad for the optimization goal (e.g performance,
speed, size) against the one that works more towards this goal.

Everything else is an optimizer BUG, which should be reported and
fixed.

The C{89,99} standard now defines the syntax and semantics of
theses terms. 

Relevant for the optimizer: possible values of terms, assumptions
made on the static and dynamic behavior of these terms (add
anything I forgot).

So the optimizer should NEVER cause trouble if you write
completely valid C{89,99} and the compiler and environment
implement 100% of the semantics of it.

Compiler specific features should be seen as an addition to the
standard on this compiler. They follow the same rules stated
above.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
