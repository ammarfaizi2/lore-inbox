Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVCCN0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVCCN0z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 08:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVCCN0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 08:26:54 -0500
Received: from smtpq1.home.nl ([213.51.128.196]:47832 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261636AbVCCNYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 08:24:55 -0500
Message-ID: <42270FD9.1020505@keyaccess.nl>
Date: Thu, 03 Mar 2005 14:23:37 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org> <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net> <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org> <4226DD45.1070107@keyaccess.nl> <4226E033.4020508@pobox.com>
In-Reply-To: <4226E033.4020508@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Rene Herman wrote:
> 
>> Doing -pre and real -rc will get you more testers for -rc. Whether or 
> 
>> Add in the fourth level .k releases for real problematic bugs found 
>> after release as you did with 2.6.8.1, and I believe things should work.
> 
> Precisely.

I assume that one of the main problems with doing -pre is that actually 
doing a real -rc isn't much fun -- I can certainly understand that 
sitting around twiddling your thumbs by decree every few weeks is not a 
good model.

You commented on the .k 4th level releases being an actual branch, BK 
wise. To not let the forced thumb-twiddling -rc period be a problem, 
this branch could happen at -rc1, after which Linus is again free to go 
merge up stuff into mainline for the next one, if he wants to.

That's to say, I propose Linus doesn't change _anything_ other than 
renaming his -rc's -pre's, and his final -rc1 (well, and making it a 
branch if -final isn't a branch now, sorry, not a clue).

The -rc branch then just sits there, and if nothing turns up that needs 
an -rc2, it gets released as final, and possibly onto .1, .2 and so on 
if useful or need be.

Now, coaching that -rc branch from -rc1 through maybe -rcN to -final and 
possibly beyond may not be something Linus wants to do. The -rc branch 
would by definition see _no_ activity other than the really needed so I 
don't believe it would be much of a burden time-wise, but it is in fact 
not unlike what Alan is already doing with -ac. So, if Linus doesn't 
want that job, Alan may? Or someone else?

Summarising:

- Linus:

	1) rename 2.6.N-rcX to 2.6.N-preX
	2) when you'd now release, branch off, release as -rc1
	3) go on with 2.6.(N+1)-pre1

- Linus, Alan, or whoever else wants the job:

	1) release -rc{2,3,...} only if needed.
	2) release 2.6.N
	3) do a 2.6.N.{1,2,...} only if needed.

Is this sane? The advantage is, real -pre's and -rc's which will get 
more people onboard testing -rc, and hopefully without annoying Linus 
with real no-changing -rc's. How many more, enough or not, remains to be 
  seen but certainly more.

Rene.
