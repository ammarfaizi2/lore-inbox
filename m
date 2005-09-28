Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVI1QVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVI1QVR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVI1QVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:21:17 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:25703 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751095AbVI1QVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:21:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=PKj9BXoPr/uGlskgS5L2uBtSYzFYOMolIPW+Uq4nZEwwq2Fzxwgxk63ipKhMNUbLeDXms1UTUteZHRE6onDoKGg//VqSdPTrahmYupaSp2pGWXvUOGSyOf1d4eQZsqyfDVkLQAlUfB0OoJKvtmBLsX/1jiH4Tdb03FYFiOcX4pM=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [uml-devel] Re: [RFC] [patch 0/18] remap_file_pages protection support (for UML), try 3
Date: Wed, 28 Sep 2005 18:20:09 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200508262023.29170.blaisorblade@yahoo.it> <200509261758.23705.blaisorblade@yahoo.it> <Pine.LNX.4.61.0509281418500.6830@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509281418500.6830@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509281820.14098.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 September 2005 15:37, Hugh Dickins wrote:
> Sorry, it's really hard to read your interspersed comments.  Perhaps I
> need to switch on some colour option when reading your mails, but I've
> never found the need for it before.  Please, use a blank line above
> and below your comments to help us locate them and read them, thanks.

Ok, will do.

> On Mon, 26 Sep 2005, Blaisorblade wrote:
> > On Wednesday 07 September 2005 14:00, Hugh Dickins wrote:
> > > So far as I can see (I may have missed it), you really don't need to
> > > change from the write boolean
> > >
> > > (perhaps -1 for exec in one arch??)
> >
> > ? Not understood this part, ignoring it?
> > Maybe you mean "except one arch, x86_64, which supports exec protection?"
>
> No, I meant the current code uses "0" for read fault, "1" for write fault,
> and (in a quick search) only found one architecture (I forget which,
> certainly not x86_64) which might have been interested to pass down
> a different value to handle_mm_fault to distinguish execution fault:
> for which I was suggesting to use "-1", rather than change everywhere.

In my local tree I've restricted the changes to generic arch code, and to 
x86_64 which uses the __handle_mm_fault with VM_EXEC if needed. The rest keep 
using handle_mm_fault (there's still the check for VM_MANYPROTS).

> Though now I'm doubting there was any such case at all.

> Hugh

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
