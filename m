Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVJKXCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVJKXCk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 19:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVJKXCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 19:02:40 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:33925 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751268AbVJKXCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 19:02:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
  b=p2CDz3WZimHIzmoc7b8BbYs2Tg3u/edkWUXkpriFPEPIYx9wYblnN+U81z8abzG+MHwolR6kdDvXWiKnpq9diFKsellk9keSiqkmKMjRbqtb7k4PKta4SPWjJqq2xeYSO9l/qbpqvHNpcgXkw9Yn9EcAiO1mQSIFZh2NRwT3+oo=  ;
Date: Wed, 12 Oct 2005 01:02:33 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Borislav Petkov <bbpetkov@yahoo.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tgraf@suug.ch,
       pablo@eurodev.net
Subject: Re: [was: Linux v2.6.14-rc4] fix textsearch build warning
Message-ID: <20051011230233.GA20187@gollum.tnic>
References: <Pine.LNX.4.64.0510101824130.14597@g5.osdl.org> <20051011145454.GA30786@gollum.tnic> <20051011205949.GU7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051011205949.GU7992@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 09:59:49PM +0100, Al Viro wrote:
> On Tue, Oct 11, 2005 at 04:54:54PM +0200, Borislav Petkov wrote:
> > I get this when building 14-rc4:
> > 
> > lib/ts_kmp.c:125: warning: initialization from incompatible pointer type
> > lib/ts_bm.c:165: warning: initialization from incompatible pointer type
> > lib/ts_fsm.c:318: warning: initialization from incompatible pointer type
> > 
> > The following trivial patch fixes it.
> 
> Umm...  I'd rather get all that stuff dealt with in one go - I've got gfp_t
> conversion finished and it's waiting for 2.6.14.
> 
> Fix for that one had been sent, actually - see part 4 of gfp_t annotations
> series.  Since none of that stuff is critical (the only bug caught so far
> had been already fixed - see relayfs patch) and Linus decided to go for
> 2.6.14-final, let's hold it back and merge as soon as 2.6.14 gets released.

Hm, I think that this is even merged already, at least the exact same one liner
I sent is in Linus' git (see commit id dd0fc66fb33cd610bc1a5db8a5e232d34879b4d7). By the way, how
can you see the patch's source by using the commit id? 
git-cat-file "blob" dd0fc66fb33cd610bc1a5db8a5e232d34879b4d7
says "bad file."

Regards,
		Boris.

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
