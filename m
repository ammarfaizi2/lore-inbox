Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUCPStr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbUCPStr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:49:47 -0500
Received: from mta10.adelphia.net ([68.168.78.202]:32453 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S261210AbUCPStf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:49:35 -0500
Subject: Re: [PATCH 9/44] Support for scroll wheel on Office keyboards
From: Aubin LaBrosse <arl8778@rit.edu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
In-Reply-To: <10794467761141@twilight.ucw.cz>
References: <10794467761141@twilight.ucw.cz>
Content-Type: text/plain
Message-Id: <1079462819.5232.257.camel@rain.rh.rit.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 13:46:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-16 at 09:19, Vojtech Pavlik wrote:
> You can pull this changeset from:
> 	bk://kernel.bkbits.net/vojtech/input
> 
> ===================================================================
> 
> ChangeSet@1.1474.188.9, 2004-01-26 13:56:47+01:00, vojtech@suse.cz
>   input: Add support for scroll wheel on MS Office and similar keyboards.
> 
> 
>  atkbd.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 58 insertions(+), 7 deletions(-)
> 
> ===================================================================
> 
> diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> --- a/drivers/input/keyboard/atkbd.c	Tue Mar 16 13:19:47 2004
> +++ b/drivers/input/keyboard/atkbd.c	Tue Mar 16 13:19:47 2004
> @@ -33,18 +33,18 @@
>  MODULE_PARM(atkbd_set, "1i");
>  MODULE_PARM(atkbd_reset, "1i");
>  MODULE_PARM(atkbd_softrepeat, "1i");
> +MODULE_PARM(atkbd_scroll, "1i");
>  MODULE_LICENSE("GPL");
>  
>  static int atkbd_set = 2;
>  module_param_named(set, atkbd_set, int, 0);
>  MODULE_PARM_DESC(set, "Select keyboard code set (2 = default, 3, 4)");
> +
>  #if defined(__i386__) || defined(__x86_64__) || defined(__hppa__)
>  static int atkbd_reset;
>  #else
>  static int atkbd_reset = 1;
>  #endif
> -static int atkbd_softrepeat;
> -
>  module_param_named(reset, atkbd_reset, bool, 0);
>  MODULE_PARM_DESC(reset, "Reset keyboard during initialization");
>  
> @@ -52,6 +52,10 @@
>  module_param_named(softrepeat, atkbd_softrepeat, bool, 0);
>  MODULE_PARM_DESC(softrepeat, "Use software keyboard repeat");
>  
> +static int atkbd_scroll;
> +module_parm_named(scroll, atkbd_scroll, bool, 0);
> +MODULE_PARM_DESC_(scroll, "Enable scroll-wheel on office keyboards");
   ^^forgive me if i am wrong, but should that not be
module_param_named, like the rest? (eg the second 'a' is missing). 
also, why MODULE_PARM_DESC_ instead of MODULE_PARM_DESC? (extra
underscore)

--aubin

