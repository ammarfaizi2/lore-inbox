Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266986AbSK2JiP>; Fri, 29 Nov 2002 04:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbSK2JiO>; Fri, 29 Nov 2002 04:38:14 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:5034 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S266986AbSK2JiO>;
	Fri, 29 Nov 2002 04:38:14 -0500
Date: Fri, 29 Nov 2002 10:45:24 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] named struct initialiser updates
In-Reply-To: <200211260414.gAQ4EaJ26436@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0211291044410.29438-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002, Linux Kernel Mailing List wrote:
> ChangeSet 1.842.43.47, 2002/11/25 18:40:22-08:00, davej@codemonkey.org.uk
> 
> 	[PATCH] named struct initialiser updates


> diff -Nru a/drivers/video/fbcon.c b/drivers/video/fbcon.c
> --- a/drivers/video/fbcon.c	Mon Nov 25 20:14:39 2002
> +++ b/drivers/video/fbcon.c	Mon Nov 25 20:14:39 2002
> @@ -230,8 +230,9 @@
>  
>  static void cursor_timer_handler(unsigned long dev_addr);
>  
> -static struct timer_list cursor_timer =
> -		TIMER_INITIALIZER(cursor_timer_handler, 0, 0);
> +static struct timer_list cursor_timer = {
> +    function: cursor_timer_handler
> +};
>  
>  static void cursor_timer_handler(unsigned long dev_addr)
>  {

Doesn't this part reverse the timer initializer fix?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

