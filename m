Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWC3G34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWC3G34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 01:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWC3G34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 01:29:56 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:44131 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751032AbWC3G34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 01:29:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vD4fsGH87jbakAlxA0mCGzEWlumiIXF4unqNU3QLxMroXUsoyPfqbGKa94Brrrw6sIy8iaRe/YmT7rp0ZFGGdXLNjDh5SRDJ4WMHpuj7hd9hxZEM+dOqXnzCDXo51JoYYjjyxVP9ZEPfK+iz8L/Yvr6U+++pu15AqLV6GzeGLGE=  ;
Message-ID: <442B4FD6.1050600@yahoo.com.au>
Date: Thu, 30 Mar 2006 14:26:14 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>	<1143228339.19152.91.camel@localhost.localdomain>	<4428BB5C.3060803@tmr.com> <20060328085206.GA14089@MAIL.13thfloor.at>	<4428FB29.8020402@yahoo.com.au>	<20060328142639.GE14576@MAIL.13thfloor.at>	<44294BE4.2030409@yahoo.com.au> <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>Nick Piggin <nickpiggin@yahoo.com.au> writes:
>
>
>>I don't think I could give a complete answer...
>>I guess it could be stated as the increase in the complexity of
>>the rest of the code for someone who doesn't know anything about
>>the virtualization implementation.
>>
>>Completely non intrusive is something like 2 extra function calls
>>to/from generic code, changes to data structures are transparent
>>(or have simple wrappers), and there is no shared locking or data
>>with the rest of the kernel. And it goes up from there.
>>
>>Anyway I'm far from qualified... I just hope that with all the
>>work you guys are putting in that you'll be able to justify it ;)
>>
>
>As I have been able to survey the work, the most common case
>is replacing a global variable with a variable we lookup via
>current.
>
>That plus using the security module infrastructure you can
>implement the semantics pretty in a straight forward manner.
>
>The only really intrusive part is that because we tickle the
>code differently we see a different set of problems.  Such
>as the mess that is the proc and sysctl code, and the lack of
>good resource limits.
>
>But none of that is inherent to the problem it is just when
>you use the kernel harder and have more untrusted users you
>see a different set of problems.
>
>

Yes... about that; if/when namespaces get into the kernel, you guys
are going to start pushing all sorts of per-container resource
control, right? Or will you be happy to leave most of that to VMs?

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
