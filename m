Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272942AbTHKTBO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272963AbTHKS7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:59:21 -0400
Received: from quito.magic.fr ([62.210.158.45]:63476 "EHLO quito.magic.fr")
	by vger.kernel.org with ESMTP id S272942AbTHKS6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:58:37 -0400
Subject: Re: 2.6.0-test2 does not boot with matroxfb
From: Jocelyn Mayer <l_indien@magic.fr>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: davej@codemonkey.org.uk, linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <9D9B6471D22@vcnet.vc.cvut.cz>
References: <9D9B6471D22@vcnet.vc.cvut.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1060628403.29141.170.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Aug 2003 21:00:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2003-08-11 at 20:29, Petr Vandrovec wrote:
> On 11 Aug 03 at 20:01, Jocelyn Mayer wrote:
> > I now run a VGA console kernel without agpgart with a 16bps X.
> > 
> > So, there seems to be two issues:
> > - broken matrox fb: I lose the synchro when switching from X to fb.
> >   fbset configuration is lost when switching consoles.
> 
> It is feature, not a bug. fbset does not work on 2.6.x kernels
> anymore. Apply 
> ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.6.0-t3-c1149.gz
> if you prefer 2.4.x behavior.
> 
In fact, it works untill I switch to another console...
What is the right way to change the console configuration at run-time,
now ? Or where should I look for this info ?
Did it become impossible (would be a severe bug, at least for me...) ?

> Also if you are using DRI, even latest XFree mga driver I found still 
> reprograms hardware even if XFree server is not on a foreground, so you 
> must use same color depth and vxres for both X and console, and even in 
> this configuration display corruption on console may occur from time to
> time...
>                                             Petr Vandrovec
>        
OK, you confirm exactly the symptom I have seen.
So it seems to be an X driver problem...
But X is still buggy when it doesn't use DRI,
at least in 32 bits modes. I know it's quite certain that it's an X bug,
but I really would like to understand why it works with 2.4 kernels
and not with 2.6 ones. The X problem is there even if I use the VGA
console (I mean with a kernel with fb support _not_ activated).

Thanks for the infos.

Regards.
                                
-- 
Jocelyn Mayer <l_indien@magic.fr>

