Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318405AbSGSRai>; Fri, 19 Jul 2002 13:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318446AbSGSRah>; Fri, 19 Jul 2002 13:30:37 -0400
Received: from monster.nni.com ([216.107.0.51]:64776 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S318405AbSGSRag>;
	Fri, 19 Jul 2002 13:30:36 -0400
Date: Fri, 19 Jul 2002 13:32:24 -0400
From: Andrew Rodland <arodland@noln.com>
To: Eli Carter <eli.carter@inet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code
Message-Id: <20020719133224.12872e48.arodland@noln.com>
In-Reply-To: <3D384C17.2010905@inet.com>
References: <20020719011300.548d72d5.arodland@noln.com>
	<20020719163654.A6010@Marvin.DL8BCU.ampr.org>
	<20020719130040.191091cd.arodland@noln.com>
	<3D384C17.2010905@inet.com>
X-Mailer: Sylpheed version 0.7.8claws55 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002 12:27:51 -0500
Eli Carter <eli.carter@inet.com> wrote:

> Andrew Rodland wrote:
> [snip]
> > --Andrew
> > 
> > P.S. Yes, in case anyone is wondering, I did create a module that
> > does nothing but generate a user-supplied panic. :)
> 
> *ROTFL*  Actually, I can see that being useful for testing...  I fear 
> you have tweaked my curiosity to see that particular implementation.
> :)
> 

Actually, it was pretty simple. It was also my first module ever.
I had a lot of fun writing all of this stuff, but people keep
indicating that maybe some of it could actually be useful. If that's
the case, so much the better.

panictest.c follows.

--cut--

#define __KERNEL__
#define MODULE

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>

static char *string = "SOS SOS SOS";

int __init panic_init(void) {
	panic(string);
}
	
module_init(panic_init);
MODULE_LICENSE("GPL");
MODULE_PARM(string, "s");
MODULE_PARM_DESC(string, "The string to panic with.");
