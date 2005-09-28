Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVI1UN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVI1UN2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVI1UN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:13:28 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:2247 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750762AbVI1UN2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:13:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oAw6uWZndVDY3xXmgEY+UefFEbJmEedCGNOwLMBrWi620m0R6b876E8Yq1oPh+D7MpX8tCFxnDh77AVJbwHvNk5lRJhHOucZgeBL71Zdlc41Ts6WjmThyA4EgdhjoLBp853TQORZ5E6pmj/3FoVLfRXdPQoOS2xPW6DZ2ZpZ3Bg=
Message-ID: <5bdc1c8b05092813131955ab8f@mail.gmail.com>
Date: Wed, 28 Sep 2005 13:13:27 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-rt6 build problems
Cc: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <5bdc1c8b05092808596a22847a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b05092808596a22847a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/05, Mark Knecht <markknecht@gmail.com> wrote:
> Hi,
>    I'm new to the list and not a developer. Please take mercy.
>
<SNIP>
>
> cd /usr/src/linux/linux-2.6.13
> patch -p1 <~mark/patch-2.6.14-rc2
> patch -p1 <~mark/patch-2.6.14-rc2-rt6
>
<SNIP>

Following up I reread Ingo's offline message to me and realized I was
supposed to try rt5 instead of tr6.

1) I downloaded 2.6.13 and built this correctly.

2) I applied the 2.6.14-rc2 patch. This built correctly also.

3) I applied the 2.6.14-rc2-rt5 patch. It failed as foloows:

include/linux/time.h: In function `div_sign_safe_ns':
include/linux/time.h:127: warning: implicit declaration of function
`div_long_lo ng_rem'
In file included from include/linux/mm.h:15,
                 from include/asm/tlbflush.h:5,
                 from arch/x86_64/kernel/reboot.c:15:
include/linux/fs.h: In function `lock_super':
include/linux/fs.h:847: warning: implicit declaration of function `down'
include/linux/fs.h: In function `unlock_super':
include/linux/fs.h:853: warning: implicit declaration of function `up'
  LD      arch/x86_64/kernel/quirks.o
  LD      arch/x86_64/kernel/i8237.o
  CC      arch/x86_64/kernel/mce.o
In file included from include/linux/timex.h:58,
                 from include/linux/sched.h:11,
                 from arch/x86_64/kernel/mce.c:11:
include/linux/time.h: In function `div_sign_safe_ns':
include/linux/time.h:127: warning: implicit declaration of function
`div_long_lo ng_rem'
In file included from arch/x86_64/kernel/mce.c:17:
include/linux/fs.h: In function `lock_super':
include/linux/fs.h:847: warning: implicit declaration of function `down'
include/linux/fs.h: In function `unlock_super':
include/linux/fs.h:853: warning: implicit declaration of function `up'
arch/x86_64/kernel/mce.c: In function `mce_read':
arch/x86_64/kernel/mce.c:392: warning: type defaults to `int' in
declaration of `DECLARE_MUTEX'
arch/x86_64/kernel/mce.c:392: warning: parameter names (without types)
in functi on declaration
arch/x86_64/kernel/mce.c:401: error: `mce_read_sem' undeclared (first
use in thi s function)
arch/x86_64/kernel/mce.c:401: error: (Each undeclared identifier is
reported onl y once
arch/x86_64/kernel/mce.c:401: error: for each function it appears in.)
make[1]: *** [arch/x86_64/kernel/mce.o] Error 1
make: *** [arch/x86_64/kernel] Error 2
lightning linux-2.6.13 #

I'll supply more info, config files, etc., if requested.

Thanks in advance,
Mark
