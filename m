Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbWDIANT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWDIANT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 20:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWDIANT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 20:13:19 -0400
Received: from [62.205.161.221] ([62.205.161.221]:39360 "EHLO kir.sacred.ru")
	by vger.kernel.org with ESMTP id S965049AbWDIANT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 20:13:19 -0400
Message-ID: <4438518A.1040801@openvz.org>
Date: Sun, 09 Apr 2006 04:12:58 +0400
From: Kir Kolyshkin <kir@openvz.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060217)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: devel@openvz.org, Sam Vilain <sam@vilain.net>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, "Serge E. Hallyn" <serue@us.ibm.com>,
       James Morris <jmorris@namei.org>
Subject: Re: [Devel] Re: [PATCH 3/7] uts namespaces: use init_utsname when
 appropriate
References: <20060407234815.849357768@sergelap>	<20060408045206.EAA8E19B8FF@sergelap.hallyn.com>	<m1psjslf1s.fsf@ebiederm.dsl.xmission.com> <1144539879.11689.1.camel@localhost.localdomain>
In-Reply-To: <1144539879.11689.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:

>On Sat, 2006-04-08 at 01:09 -0600, Eric W. Biederman wrote:
>  
>
>>>-#define ELF_PLATFORM  (system_utsname.machine)
>>>+#define ELF_PLATFORM  (init_utsname()->machine)
>>> 
>>> #ifdef __KERNEL__
>>> #define SET_PERSONALITY(ex, ibcs2) do { } while (0)
>>>      
>>>
>>I think this one needs to be utsname()->machine.
>>Currently it doesn't matter.  But Herbert has expressed
>>the desire to make a machine appear like an older one.
>>    
>>
>
>This is extremely useful for faking it as "i386" on x86_64 systems, for
>instance.
>  
>
Could 'setarch' be of any help here? Works fine for us. Or am I missing 
something?
