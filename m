Return-Path: <linux-kernel-owner+w=401wt.eu-S1753533AbWLRIpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbWLRIpZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 03:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753534AbWLRIpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 03:45:25 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:43932 "HELO
	smtp101.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753533AbWLRIpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 03:45:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=khIlXTDfOjFuqBrHuEfioTwZNQTIYbU8GE/6w/oKH15+TBTDR2QkFlUXQqJyJ4VK78eJV9Vcv5kzQg5ASdSQ8o3yyLO5jjWEqd3jDSMZTI2bP5hWfoiFs2leZgd2RTNOphMV82RZfl4Gfc8j+7VHBjaYU8ZqOumCJoHeiT90p/w=  ;
X-YMail-OSG: XVcPK7kVM1nEoY6HIVFWV.cle92i8F5s_BVcp9vbLqK3aFZuxtDQyoLI65qjTKP7V5e3uDec3J4ws8bKT_aI3QHd5gNNnyLQRkJL.s1vF8QwxCN9pIqyQ1sqH2ZMvVy_tHZz19arkC3pnVI-
Message-ID: <45864380.1010201@yahoo.com.au>
Date: Mon, 18 Dec 2006 18:30:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
References: <1166314399.7018.6.camel@localhost> <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost> <20061217154026.219b294f.akpm@osdl.org> <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org> <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org> <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org> <45861E68.3060403@yahoo.com.au> <Pine.LNX.4.64.0612172145250.3479@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612172145250.3479@woody.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 18 Dec 2006, Nick Piggin wrote:
> 
>>I can't see how that's exactly a problem -- so long as the page does not
>>get reclaimed (it won't, because we have a ref on it) then all that matters
>>is that the page eventually gets marked dirty.
> 
> 
> But the point being that "try_to_free_buffers()" marks it clean 
> AFTERWARDS.

For some reason I thought you were suggesting it is a problem on its own :P

Yes I agree there is a pagefault vs ttfb race.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
