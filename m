Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbUALCRN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 21:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266020AbUALCRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 21:17:12 -0500
Received: from mail.bluebottle.com ([69.20.6.25]:9361 "EHLO mail.bluebottle")
	by vger.kernel.org with ESMTP id S266011AbUALCRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 21:17:07 -0500
Date: Mon, 12 Jan 2004 00:17:03 -0200 (BRST)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: Vojtech Pavlik <vojtech@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: The key "/ ?" on my abtn2 keyboard is dead with kernel
 2.6.1
In-Reply-To: <20040111235025.GA832@ucw.cz>
Message-ID: <Pine.LNX.4.58.0401120004110.601@pervalidus.dyndns.org>
References: <200401111545.59290.murilo_pontes@yahoo.com.br> <20040111235025.GA832@ucw.cz>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech, he reported the same problem I have. The "/ ?" key not
working anymore with ABNT2 keyboards.

I tested with the patch and it didn't fix it on the console.
I'm using kbd 1.10.

showkey under 2.4:

keycode  89

showkey under 2.6.1:

keycode   0 press
keycode   1 release
keycode  53 release
keycode   0 release
keycode   1 release
keycode  53 release

It works with XFree86.

Since 2.6.0 worked, I assume something broke it.

Mon, 12 Jan 2004, Vojtech Pavlik wrote:

> On Sun, Jan 11, 2004 at 03:45:59PM +0000, Murilo Pontes wrote:
>
> > 15:34:36 [root@murilo:/MRX/drivers]#diff -urN linux-2.6.0/drivers/input/keyboard/atkbd.c linux-2.6.1/drivers/input/keyboard/atkbd.c > test.diff
> > 15:35:12 [root@murilo:/MRX/drivers]#wc -l test.diff
> >     387 test.diff
> > -------------> May be wrong?!
>
> Yes, there was a mistake by me in a related patch.
>
> This should fix it.
>
> diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
> --- a/drivers/char/keyboard.c	Sun Jan 11 19:42:55 2004
> +++ b/drivers/char/keyboard.c	Sun Jan 11 19:42:55 2004
> @@ -941,8 +941,8 @@
>  	 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
>  	 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
>  	 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
> -	 80, 81, 82, 83, 84, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
> -	284,285,309,311,312, 91,327,328,329,331,333,335,336,337,338,339,
> +	 80, 81, 82, 83, 43, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
> +	284,285,309,298,312, 91,327,328,329,331,333,335,336,337,338,339,
>  	367,288,302,304,350, 89,334,326,116,377,109,111,126,347,348,349,
>  	360,261,262,263,298,376,100,101,321,316,373,286,289,102,351,355,
>  	103,104,105,275,287,279,306,106,274,107,294,364,358,363,362,361,

-- 
http://www.pervalidus.net/contact.html
