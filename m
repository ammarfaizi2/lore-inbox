Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266269AbRGGOMw>; Sat, 7 Jul 2001 10:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266277AbRGGOMn>; Sat, 7 Jul 2001 10:12:43 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:27848 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266269AbRGGOMa>;
	Sat, 7 Jul 2001 10:12:30 -0400
Message-ID: <3B4718CC.483CE54E@mandrakesoft.com>
Date: Sat, 07 Jul 2001 10:12:28 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kaos@ocs.com.au, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: modules and 2.5
In-Reply-To: <m15ISwa-000CGGC@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> In message <3B415489.77425364@mandrakesoft.com> you write:
> > A couple things that would be nice for 2.5 is
> > - let MOD_INC_USE_COUNT work even when module is built into kernel, and
> > - let THIS_MODULE exist and be valid even when module is built into
> > kernel
> 
> Hi Jeff,
> 
> What use are module use counts, if not used to prevent unloading?

IMHO you should be free to bump the module reference count up and down
as you wish, and be able to read the module reference count.

If you make that assumption, then it becomes possible to use the module
ref count as an internal reference counter, for device opens or
something like that.

In i810_rng.c it eliminated the need for an additional reference
count... until I attempted to compile it into the kernel instead of as a
module, for the first time :)

	Jeff


-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
