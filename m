Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUGZRda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUGZRda (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 13:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUGZRd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 13:33:29 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:61599 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S266177AbUGZQEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 12:04:32 -0400
Date: Mon, 26 Jul 2004 18:04:24 +0200
From: David Weinehall <tao@debian.org>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interesting race condition...
Message-ID: <20040726160424.GQ22472@khan.acc.umu.se>
Mail-Followup-To: Marc Ballarin <Ballarin.Marc@gmx.de>,
	linux-kernel@vger.kernel.org
References: <200407222204.46799.rob@landley.net> <20040723073300.GA4502@ip68-4-98-123.oc.oc.cox.net> <200407240313.19053.rob@landley.net> <loom.20040724T152713-574@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20040724T152713-574@post.gmane.org>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2004 at 01:40:59PM +0000, Marc Ballarin wrote:
> Rob Landley <rob <at> landley.net> writes: 
>  
> > Oh I can't reproduce it either.  (Maybe if I set some kind of loop and left 
> > it running for a few days...) 
>  
> I could reproduce it on an otherwise idle system (2 GHz Athlon, kernel 2.6.7). 
> On a loaded system the bug did not occur, which certainly indicates a race 
> condition. 
>  
> Using the following Bash script, the bug appeared 23 times in 122,221 
> iterations: 
> while [ 1 ];do 
>         ps ax | grep hack >> TEST 
> done 
>  
> The bug *seems* to be in bash, since an equivalent script in tcsh had no 
> problems: 
> while ( 1 ) 
>         ps ax | grep hack >> TEST2 
> end 
>  
> This issue has the potential to break a lot of shell scripts in an almost 
> undebugable way. Should someone file a bug report via 'bashbug'? 

I get this using posh as well, so it doesn't seem to be bash-specific.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
