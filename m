Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265392AbUAWI6e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 03:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266544AbUAWI6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 03:58:31 -0500
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:59001 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265392AbUAWI6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 03:58:30 -0500
Subject: Re: uk keyboard broken by input updates?
From: Bastien Nocera <hadess@hadess.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Kieran <kieran@ihateaol.co.uk>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040112103256.GA4038@ucw.cz>
References: <1073901824.29420.14.camel@bnocera.surrey.redhat.com>
	 <40027510.1080600@ihateaol.co.uk>  <20040112103256.GA4038@ucw.cz>
Content-Type: text/plain
Message-Id: <1074848307.2358.1.camel@wyatt.hadess.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Fri, 23 Jan 2004 08:58:27 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vojtech,

Is there any particular reason why this didn't make it into 2.6.2-rc1? I
just checked the 2.6.1 to 2.6.2-rc1 patch, and the only change to
char/keyboard.c seems to be a change in an #ifdef.

Cheers

On Mon, 2004-01-12 at 10:32, Vojtech Pavlik wrote:
> On Mon, Jan 12, 2004 at 10:21:04AM +0000, Kieran wrote:
> > I have exactly the same problem using 2.6.1 and an IBM USB keyboard, not 
> > really had a chance to look into it yet though.
> 
> Can you check if this fixes it for you?
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
---
Bastien Nocera <hadess@hadess.net> 
Remember the 3 golden rules: 1. It was like that when I got here. 2. I
didn't do it. 3. (To your Boss) I like your style.

