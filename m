Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbVIEX21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbVIEX21 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 19:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbVIEX21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 19:28:27 -0400
Received: from smtpout.mac.com ([17.250.248.87]:62687 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964951AbVIEX21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 19:28:27 -0400
In-Reply-To: <dfhs4u$1ld$1@terminus.zytor.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050903064124.GA31400@codepoet.org> <4319BEF5.2070000@zytor.com> <B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com> <dfhs4u$1ld$1@terminus.zytor.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5A37B032-9BBD-4AEA-A9BF-D42AFF79BC86@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Mon, 5 Sep 2005 19:28:07 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 5, 2005, at 12:35:42, H. Peter Anvin wrote:
> Followup to:  <B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com>
> By author:    Kyle Moffett <mrmacman_g4@mac.com>
> In newsgroup: linux.dev.kernel
>
>> Didn't you mean "#define stat __kabi_stat64"?  Also, I can see that
>> would pose other issues as well say my app does "struct stat stat;"
>> Any error messages would refer to a variable "__kabi_stat64" instead
>> of the expected "stat":
>
> No, I didn't.  That's *exactly* why I didn't mean that.
>
> #define __kabi_stat64 stat
> #include <linux/abi/stat.h>
>
> That being said, I would personally like to see it possible to typedef
> struct, union and enum tags.

_OH_!!! Forgive me for missing the point entirely!  I can see how  
that would
work very well.  Nice trick, BTW!  Very sneaky, needs significant  
explanatory
comments in whatever header file it ends up in lest others get  
confused in
the same fashion as I.  With all of that mess out of the way, I'll  
work on
getting a few initial RFC patches out the door, and then we can  
revisit this
discussion once there is something tangible to talk about.

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best  
answer:

"Why do musicians compose symphonies and poets write poems? They do  
it because
life wouldn't have any meaning for them if they didn't. That's why I  
draw
cartoons. It's my life."
   -- Charles Shultz


