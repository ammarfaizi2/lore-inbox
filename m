Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277324AbRJEHMR>; Fri, 5 Oct 2001 03:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277325AbRJEHMH>; Fri, 5 Oct 2001 03:12:07 -0400
Received: from t2.redhat.com ([199.183.24.243]:63476 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S277324AbRJEHL5>; Fri, 5 Oct 2001 03:11:57 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011004183415.A6357@dot.cygnus.com> 
In-Reply-To: <20011004183415.A6357@dot.cygnus.com> 
To: Richard Henderson <rth@dot.cygnus.com>
Cc: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: alpha 2.4.11-pre3: delay disabling early boot messages 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Oct 2001 08:12:23 +0100
Message-ID: <17968.1002265943@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rth@dot.cygnus.com said:
> Alpha has this nice way to output console messages via SRM callbacks
> which we can enable immediately on bootup, and so get debugging output
> before console_init.  This patch delays when we turn that off, and so
> narrows the window in which we can't get debug output. 

Putting it in time_init() because we happen to know that time_init() is the 
last thing called from init/main.c before console_init() is a bit of a 
hack :)

I've wanted this on other platforms too - couldn't we add an 
unregister_boot_console() to console_init() instead?

--
dwmw2


