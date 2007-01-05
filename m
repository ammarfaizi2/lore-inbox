Return-Path: <linux-kernel-owner+w=401wt.eu-S1030337AbXAEFgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbXAEFgj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 00:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbXAEFgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 00:36:38 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:41900 "HELO
	smtp108.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030337AbXAEFgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 00:36:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=A7IAIIcjIQ5iiNA1XoI7vTIZvyxE3czboyoeNmgf4upor3ZH9iCsJcVtmFBesQZ+CmW9KThPRgroWxMYkng9iUzsCG9uJFUNXN6PnSR6t8iO6wJTUxpohzzwHPDHSy+mQDLBzmoZ/dGacK2ZW1h7nwsAdvMDNzqEXZpLNBmEGjw=  ;
X-YMail-OSG: fZOpAPQVM1kS2.Xf0cgFUzDB469MX88Z9KcatHMvrRc93OavzmRNuANAlXcSoxj1ODrJRK4aje8bsaLArDmQBXpUDIOl_JaOTEwtfmMIDkFxg_gommvVaTglYMqtgI77DI7yuEqGXEtOIDicTYfalDzSSgxovT9F4h7xY_ByIUCgNNK5HtwUKgDFkga2
Message-ID: <459DE3C6.20302@yahoo.com.au>
Date: Fri, 05 Jan 2007 16:36:06 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Gelmini <gelma@gelma.net>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
References: <200612291859.kBTIx2kq031961@hera.kernel.org> <20061229224309.GA23445@gelma.net> <459734CE.1090001@yahoo.com.au> <20061231135031.GC23445@gelma.net> <459C7B24.8080008@yahoo.com.au> <Pine.LNX.4.64.0701032031400.3661@woody.osdl.org> <20070103214121.997be3e6.akpm@osdl.org> <459C98BF.5080409@yahoo.com.au> <20070104131612.GC28470@gelma.net>
In-Reply-To: <20070104131612.GC28470@gelma.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Gelmini wrote:
> On Thu, Jan 04, 2007 at 05:03:43PM +1100, Nick Piggin wrote:
> 
>>Anyway that leaves us with the question of why Andrea's database is getting
>>corrupted. Hopefully he can give us a minimal test-case.
> 
> 
> yep, I can give you a complete image of my machine, or a root access.
> replicate the problem it's not complicated, but it requires some time
> (you have to expire/update usenet/newsgroup headers).
> I can talk with Bauno to see if he can produce an automated program that
> replicate user behavior.

Myself, I don't think I have the time or capability to help much if the
corruption involves a complicated set of userspace software, especially
if you don't have a point where a regression was introduced.

I was thinking like a 100 line C program that I can reproduce here ;)

If you can even describe the steps it does: (eg. mmap file A, write(2) to
it, truncate it, ...., should contain 1s but it contains 0s!), then we
might have some suggestions to try.

One obvious thing is change filesystems or filesystem block sizes, try
ext2 or even tmpfs. Another is to try using write(2) instead of mmap to
write data.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
