Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVCCSIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVCCSIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 13:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbVCCSHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 13:07:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50321 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262054AbVCCSFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:05:16 -0500
Message-ID: <422751C1.7030607@pobox.com>
Date: Thu, 03 Mar 2005 13:04:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net> <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org> <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com> <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> In fact, if somebody maintained that kind of tree, especially in BK, it 
> would be trivial for me to just pull from it every once in a while (like 
> ever _day_ if necessary). But for that to work, then that tree would have 
> to be about so _obviously_ not wild patches that it's a no-brainer.
> 
> So what's the problem with this approach? It would seem to make everybody
> happy: it would reduce my load, it would give people the alternate "2.6.x
> base kernel plus fixes only" parallell track, and it would _not_ have the 
> testability issue (because I think a lot of people would be happy to test 
> that tree, and if it was always based on the last 2.6.x release, there 
> would be no issues.

The only problem I see with this -- and its a minor problem -- is that 
some patches that belong in the 2.6.X.Y tree go straight to you/Andrew, 
rather than to $sucker.

It's perfectly workable from a BK standpoint to do

	-> linux-2.6 commit
	-> cpcset into linux-2.6.X.Y [see Documentation/BK-usage/cpcset]
	-> pull from linux-2.6.X.Y into linux-2.6 [dups cset, but no
	   real code change]

but that causes dups in the BK changelog and history.  Not a big deal, 
though, just a minor technical nit.

	Jeff


