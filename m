Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWCDOMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWCDOMx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 09:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWCDOMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 09:12:53 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:5755 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750804AbWCDOMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 09:12:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=WN7vj2yTvcdEAHYaIXave1/0U9h0JfPZeZZVVq3OxFqHJfr0iX4TwfrU9epPVhu57+0ZigxtdaFXhO7OLC8CWnDFbILHjZRB+wZMfI/fzKyOmjcVnvOge1pvgL3j5hzCd6nCcI7q45g9bMEJQ/coLZLLDuiLMP1Sjf1/quuOjG4=  ;
Message-ID: <4409A05F.2090704@yahoo.com.au>
Date: Sun, 05 Mar 2006 01:12:47 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       bunk@stusta.de, Geert Uytterhoeven <geert@linux-m68k.org>,
       linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc regression: m68k CONFIG_RMW_INSNS=n compile broken
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060303230149.GB9295@stusta.de> <Pine.LNX.4.64.0603031515321.22647@g5.osdl.org> <20060303155913.2e299736.akpm@osdl.org> <Pine.LNX.4.64.0603041457070.16802@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0603041457070.16802@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Fri, 3 Mar 2006, Andrew Morton wrote:
> 
> 
>>Yes, we now require cmpxchg of all architectures.
> 
> 
> Actually I'd prefer if we used atomic_cmpxchg() instead.
> The cmpxchg() emulation was never added for a good reason - to keep code 
> from assuming it can be used it for userspace synchronisation. Using an 
> atomic_t here would probably get at least some attention.
> 

Yes, I guess that's what Andrew meant. The reason we can require
atomic_cmpxchg of all architectures is because it is only guaranteed
to work on atomic_t.

Glad to hear it won't be a problem for you though.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
