Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbVI1QlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbVI1QlM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVI1QlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:41:12 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:32344 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751422AbVI1QlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:41:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=wssTIg+V3+zs7hm5nvdhz/l9ZMF/pTbcznO9Z7l55bcAUJre0G3ttiTSj49xfWNoUxYxTiB7IZDDDh33/opqm3mDbhHUC+48LgcQW+jFxIJkss56oQgxD/9DT4cYHODLiaQaqPwgC6zwFL5Av/gKqg4/xWbA2pjYBFX2ckR0+2Y=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: Uml showstopper bugs for 2.6.14
Date: Wed, 28 Sep 2005 18:40:22 +0200
User-Agent: KMail/1.8.2
Cc: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200509271846.51804.blaisorblade@yahoo.it> <200509281415.18586.blaisorblade@yahoo.it> <20050928145250.GB11610@ccure.user-mode-linux.org>
In-Reply-To: <20050928145250.GB11610@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509281840.23816.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 September 2005 16:52, Jeff Dike wrote:
> On Wed, Sep 28, 2005 at 02:15:18PM +0200, Blaisorblade wrote:
> > Do you know when this was introduced, and the last working UML version?

> It's always been broken, I think.
Ah, but you're talking of SKAS0.

In this case (which seems strange, given the number of people using x86_64 and 
not complaining - or maybe it's just me who didn't say "enable frame 
pointers" to any of the various bug reports), if the patch is not trivial 
enough (it seems to be), make sure to at least force frame pointers.

Even if I think, if I understood the thing correctly, that this workaround is 
not even guaranteed to work.

> It results from the stub having to 
> sigreturn by hand because it has no access to the libc restorer, and thus
> needing to restore the stack pointer to where it was on entry.  I did this
> by popping the requisite number of times.

> Bodo fixed this for i386,
By restoring in sp the address of first param (or something like that), right?
> and  
> I need to do something similar for x86_64.

The bug killing almost everybody testing 2.6.12-bb? In this case, it's SKAS0 
specific.

But especially, couldn't this be triggered by another GCC version, changing 
the stack layout?
> 				Jeff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com
