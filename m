Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265592AbRFWByj>; Fri, 22 Jun 2001 21:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265597AbRFWBy3>; Fri, 22 Jun 2001 21:54:29 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:30735 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265592AbRFWByR>;
	Fri, 22 Jun 2001 21:54:17 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "J . A . Magallon" <jamagallon@able.es>
cc: "Justin T . Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx 
In-Reply-To: Your message of "Sat, 23 Jun 2001 03:20:47 +0200."
             <20010623032047.A14928@werewolf.able.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 23 Jun 2001 11:54:10 +1000
Message-ID: <11682.993261250@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2001 03:20:47 +0200, 
"J . A . Magallon" <jamagallon@able.es> wrote:
>On 20010623 Keith Owens wrote:
>>Justin Gibbs wrote
>>
>>>What again are you trying to fix?  It looks to me like you are simply
>>>trying to make it harder for people actually working on the aic7xxx
>>>driver to have proper dependencies.
>>
>>The patch still works for anybody changing the aic7xxx firmware or the
>>aicasm code.  Any change to the generated files or the aicasm files now
>>forces a rebuild, the option is not required.  Only people changing
>>aic7xxx firmware are affected, instead of everybody.
>
>It is easier than that. Nobody should be rebuilding the firmware apart
>from driver mantainers ...
>If there are updates to the firmware, just send the patch for .h files
>to kernel mantainers and/or lkml, as everybody does.
>This is easier, doesn't it ?

Much easier but

(a) against the spirit of the GPL, no source code to generate the headers
(b) it makes it harder for people other than Justin to work on the
    firmware.

IMNSHO the kernel should not contain generated files without the
support to regenerate them.  If that means a little more work for the
kbuild maintainers then so be it, I have done that extra work.

