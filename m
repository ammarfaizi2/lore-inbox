Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273076AbTHKSob (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273032AbTHKSnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:43:24 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:1978 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S272919AbTHKSde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:33:34 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Valdis.Kletnieks@vt.edu
Date: Mon, 11 Aug 2003 20:33:13 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] Remove useless assertions from reiserfs 
Cc: davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
X-mailer: Pegasus Mail v3.50
Message-ID: <9D9C5DC650E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Aug 03 at 14:00, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 11 Aug 2003 13:45:30 EDT, Jeff Garzik said:
> > Why are these useless?
> 
> > >     if (len >= 12)
> > >     {          
> > >      //assert(len < 16);
> > >               if (len >= 16)
> > >                    BUG();
> > 
> > Seems like a valid check to me...
> 
> Just before that, there's code:
> 
>      while(len >= 16)
>         {
>     ...
>                 len -= 16;
>             }
> 
> So if that ever exits with a len >=16, we have a SERIOUS problem with
> either the compiler or the hardware - as such, that "if (..) BUG" is dead code.
> Similarly for the other checks.

I always thought that assertions are just for that - if you can hit them
without some unexpected event/bug, you have a SERIOUS problem.
                                                    Petr Vandrovec
                                                    

