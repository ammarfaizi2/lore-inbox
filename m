Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbRGCHpI>; Tue, 3 Jul 2001 03:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266457AbRGCHos>; Tue, 3 Jul 2001 03:44:48 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:51622 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266463AbRGCHoi>;
	Tue, 3 Jul 2001 03:44:38 -0400
Message-ID: <3B4177E4.CEFB99FB@mandrakesoft.com>
Date: Tue, 03 Jul 2001 03:44:36 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: Sean Hunter <sean@dev.sportingbet.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: modules and 2.5
In-Reply-To: <2422.994145942@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> Human error.  Create a new kernel with something built in which used to
> be a module and forget to make modules_install, so the code is in the
> kernel and in /lib/modules.  Then do an explicit insmod, if probing
> does not fail the module load then oops is all she wrote.

It still sounds like a driver bug.  It is the driver's responsibility to
ensure its resources are locked down for its own use.

Probing should not succeed if there is an existing driver in the
kernel.  request_??? and register_??? functions return failure to
guarantee this sort of thing.

Someone please provide a list of drivers which behave in this manner, so
that they can be fixed up.

Regards,

	Jeff


-- 
Jeff Garzik      | "I respect faith, but doubt is
Building 1024    |  what gives you an education."
MandrakeSoft     |           -- Wilson Mizner
