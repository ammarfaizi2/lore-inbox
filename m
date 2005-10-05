Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbVJEVZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbVJEVZq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVJEVZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:25:46 -0400
Received: from xproxy.gmail.com ([66.249.82.193]:22588 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030314AbVJEVZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:25:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FuRv2AS4/bdSSKmP/O3Vy2dlxI7tAwafCZbl7QmtnhMVJs7/Ch4bhHCWGTGRAcY/BP3r/tapLKWszHNgUa+C3fkhIMjE4JdFwjNTUI1c/9SxIrRxqYvHT/r1qVoeRT/78B1vRVpKjXcbFx7B4LnK17DCUOeUCE+4Cp35LloQFXU=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Documentation: ksymoops should no longer be used to decode Oops messages
Date: Wed, 5 Oct 2005 23:28:22 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Chris Ricker <kaboom@gatech.edu>,
       chris.ricker@genetics.utah.edu, Linus Torvalds <torvalds@osdl.org>
References: <200510052239.43492.jesper.juhl@gmail.com> <20051005212850.GD27229@mipter.zuzino.mipt.ru>
In-Reply-To: <20051005212850.GD27229@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510052328.22969.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 October 2005 23:28, Alexey Dobriyan wrote:
> On Wed, Oct 05, 2005 at 10:39:43PM +0200, Jesper Juhl wrote:
> > Document the fact that ksymoops should no longer be used to decode Oops
> > messages.
> 
> If it's considered harmful, better remove all references to ksymoops.
> 2.4 users will happily grab their copy of this file from 2.4 tree.
> 

I opted to keep the entry but make an explicit note that ksymoops should not
be used for 2.6 kernels to make it clear. There are still people who use 
ksymoops on 2.6 Oops messages, so I thought it would make sense to keep the
entry but make it clear that you should /not/ do that.

But, I'm fine with removing it as well.

> >  Ksymoops
> >  --------
> >  
> > -If the unthinkable happens and your kernel oopses, you'll need a 2.4
> > -version of ksymoops to decode the report; see REPORTING-BUGS in the
> > -root of the Linux source for more information.
> > +With a 2.4 kernel you need ksymoops to decode a kernel Oops message. With
> > +2.6 kernels ksymoops is no longer needed and should not be used.
> 

Here's a patch to remove the Ksymoops entry instead.

I'll leave it up to the powers that be to sprinkle holy penguin pee on the
preferred version.



Ksymoops should not be used on 2.6 Oops messages, so remove the ksymoops entry
from Documentation/Changes

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/Changes |    9 +--------
 1 files changed, 1 insertion(+), 8 deletions(-)

--- linux-2.6.14-rc3-git5-orig/Documentation/Changes	2005-10-03 21:54:50.000000000 +0200
+++ linux-2.6.14-rc3-git5/Documentation/Changes	2005-10-05 23:21:45.000000000 +0200
@@ -31,7 +31,7 @@
 Eine deutsche Version dieser Datei finden Sie unter
 <http://www.stefan-winter.de/Changes-2.4.0.txt>.
 
-Last updated: October 29th, 2002
+Last updated: October 05th, 2005
 
 Chris Ricker (kaboom@gatech.edu or chris.ricker@genetics.utah.edu).
 
@@ -136,13 +136,6 @@
 types, have a fdformat which works with 2.4 kernels, and similar goodies.
 You'll probably want to upgrade.
 
-Ksymoops
---------
-
-If the unthinkable happens and your kernel oopses, you'll need a 2.4
-version of ksymoops to decode the report; see REPORTING-BUGS in the
-root of the Linux source for more information.
-
 Module-Init-Tools
 -----------------
 


