Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271411AbTHDHal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 03:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271412AbTHDHal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 03:30:41 -0400
Received: from [203.53.213.67] ([203.53.213.67]:3346 "EHLO exchange.world.net")
	by vger.kernel.org with ESMTP id S271411AbTHDHak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 03:30:40 -0400
Message-ID: <6416776FCC55D511BC4E0090274EFEF5080024B7@exchange.world.net>
From: Steven Micallef <steven.micallef@world.net>
To: "'Torsten Foertsch'" <torsten.foertsch@gmx.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: chroot() breaks syslog() ?
Date: Mon, 4 Aug 2003 17:30:34 +1000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> consider syslogd's -a option. Or simply call openlog(3) with 
> LOG_NDELAY before 
> chroot(). Or place the first call to syslog() before 
> chroot(). Syscall() does 
> not close the socket between calls.
> 
> int main(void) {
>   openlog( "klaus", LOG_NDELAY, LOG_NEWS);
>   chroot("/tmp");
>   printf( "before\n" ); fflush( stdout );
>   syslog(LOG_ALERT, "TEST1");
>   printf( "between\n" ); fflush( stdout );
>   syslog(LOG_ALERT, "TEST2");
> }

That works perfectly, thanks.

Regards,

Steve.
