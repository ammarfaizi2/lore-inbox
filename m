Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129693AbRBAIPS>; Thu, 1 Feb 2001 03:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129671AbRBAIPI>; Thu, 1 Feb 2001 03:15:08 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:26197 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129580AbRBAIPB>; Thu, 1 Feb 2001 03:15:01 -0500
Message-ID: <3A791A9D.1B2D0EEA@sgi.com>
Date: Thu, 01 Feb 2001 00:13:17 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Power usage Q and parallel make question (separate issues)
In-Reply-To: <11659.980998327@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Wed, 31 Jan 2001 19:02:03 -0800,
> LA Walsh <law@sgi.com> wrote:
> >This seems to serialize the delete, run the mod-installs in parallel, then run the
> >depmod when they are done.
> 
> It works, until somebody does this
> 
>  make -j 4 modules modules_install
---
	But that doesn't work now.  

> There is not, and never has been, any interlock between make modules
> and make modules_install.  If you let modules_install run in parallel
> then people will be tempted to issue the incorrect command above
> instead of the required separate commands.
---
	
> 
>  make -j 4 modules
>  make -j 4 modules_install
> 
> You gain a few seconds on module_install but leave more room for user
> error.
---
	A bit of documentation at the beginning of the Makefile would do wonders
for kernel-developer (not end user, please!) clarity.  I've oft'asked the question
as to what really is supported.  I've tried things like make dep bzImage modules --
I noticed it didn't work fairly quickly.  Same with modules/modules_install -- 
people would probably figure that one out, but just a bit of documentation would
help even that.  


	
-- 
Linda A Walsh                    | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
