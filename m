Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVACNR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVACNR4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 08:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVACNR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 08:17:56 -0500
Received: from styx.suse.cz ([82.119.242.94]:16303 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261439AbVACNRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 08:17:53 -0500
Date: Mon, 3 Jan 2005 14:18:48 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osld.org, akpm@osdl.org
Subject: Re: [bk patches] Long delayed input update
Message-ID: <20050103131848.GH26949@ucw.cz>
References: <20041227142821.GA5309@ucw.cz> <200412271419.46143.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412271419.46143.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 02:19:43PM -0500, Dmitry Torokhov wrote:
> On Monday 27 December 2004 09:28 am, Vojtech Pavlik wrote:
> > ChangeSet@1.1957.1.21, 2004-10-21 23:52:36-05:00, dtor_core@ameritech.net
> > ? Input: i8042 - allow turning debugging on and off "on-fly"
> > ? ? ? ? ?so people do not have to recompile their kernels to
> > ? ? ? ? ?provide debug info.
> > ? 
> > ? ? ? ? ?Adds new parameter i8042.debug also accessible through
> > ? ? ? ? ?sysfs. 
> > ? 
> > ? Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> Hi,
> 
> This one needs the patch below to correct permissions braindamage.

Applied. Linus, please pull now.

> ===================================================================
> 
> 
> ChangeSet@1.1968, 2004-11-25 00:33:20-05:00, dtor_core@ameritech.net
>   Input: i8042 - fix "debug" parameter sysfs permissions.
>   
>   Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> 
>  i8042.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> 
> ===================================================================
> 
> 
> 
> diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> --- a/drivers/input/serio/i8042.c	2004-11-25 01:27:15 -05:00
> +++ b/drivers/input/serio/i8042.c	2004-11-25 01:27:15 -05:00
> @@ -68,7 +68,7 @@
>  #define DEBUG
>  #ifdef DEBUG
>  static int i8042_debug;
> -module_param_named(debug, i8042_debug, bool, 600);
> +module_param_named(debug, i8042_debug, bool, 0600);
>  MODULE_PARM_DESC(debug, "Turn i8042 debugging mode on and off");
>  #endif

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
