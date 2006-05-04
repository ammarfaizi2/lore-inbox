Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWEDO7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWEDO7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 10:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWEDO7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 10:59:00 -0400
Received: from [84.204.75.166] ([84.204.75.166]:13710 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP
	id S1751460AbWEDO67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 10:58:59 -0400
Message-ID: <445A16B1.8080407@oktetlabs.ru>
Date: Thu, 04 May 2006 18:58:57 +0400
From: "Artem B. Bityutskiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060202 Fedora/1.7.12-1.5.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 5/13: eCryptfs] Header declarations
References: <20060504031755.GA28257@hellewell.homeip.net>	 <20060504033750.GD28613@hellewell.homeip.net> <84144f020605040751t2d2dca5ai4044f28d7118ee96@mail.gmail.com>
In-Reply-To: <84144f020605040751t2d2dca5ai4044f28d7118ee96@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
>> +#ifdef OBSERVE_ASSERTS
>> +#define 
>> ASSERT(EX)                                                           \
>> +do 
>> {                                                                         
>> \
>> +        if (unlikely(!(EX))) 
>> {                                                \
>> +               printk(KERN_CRIT "ASSERTION FAILED: %s at %s:%d 
>> (%s)\n", #EX, \
>> +                      __FILE__, __LINE__, 
>> __FUNCTION__);                     \
>> +                
>> BUG();                                                        \
>> +        
>> }                                                                    \
>> +} while (0)
>> +#else
>> +#define ASSERT(EX) ;
>> +#endif /* OBSERVE_ASSERTS */
> 
> So, what's wrong with BUG_ON?
>
I guess because this may be compiled off when no debugging/extra 
checking is needed.


-- 
Best regards, Artem B. Bityutskiy
Oktet Labs (St. Petersburg), Software Engineer.
+7 812 4286709 (office) +7 911 2449030 (mobile)
E-mail: dedekind@oktetlabs.ru, Web: www.oktetlabs.ru
