Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316824AbSG3VyQ>; Tue, 30 Jul 2002 17:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316825AbSG3VyQ>; Tue, 30 Jul 2002 17:54:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29448 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316824AbSG3VyP>; Tue, 30 Jul 2002 17:54:15 -0400
Date: Tue, 30 Jul 2002 22:57:36 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: Re: [patch] Fix suspend of the kseriod thread
Message-ID: <20020730225736.K7677@flint.arm.linux.org.uk>
References: <20020730122638.A11153@ucw.cz> <20020730122918.A11248@ucw.cz> <20020730152255.A20071@ucw.cz> <20020730152342.B20071@ucw.cz> <20020730221722.A22761@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020730221722.A22761@ucw.cz>; from vojtech@suse.cz on Tue, Jul 30, 2002 at 10:17:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 10:17:22PM +0200, Vojtech Pavlik wrote:
>  	do {
>  		serio_handle_events();
> +		interruptible_sleep_on(&serio_wait); 
>  		if (current->flags & PF_FREEZE)
>  			refrigerator(PF_IOTHREAD);
> -		interruptible_sleep_on(&serio_wait); 
>  	} while (!signal_pending(current));

Isn't interruptible_sleep_on() taboo?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

