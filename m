Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293145AbSBWPVt>; Sat, 23 Feb 2002 10:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293146AbSBWPVa>; Sat, 23 Feb 2002 10:21:30 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:180 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S293145AbSBWPVG>; Sat, 23 Feb 2002 10:21:06 -0500
Date: Sat, 23 Feb 2002 16:21:00 +0100
From: bert hubert <ahu@ds9a.nl>
To: Dan Aloni <da-x@gmx.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] C exceptions in kernel
Message-ID: <20020223162100.A1952@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Dan Aloni <da-x@gmx.net>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1014412325.1074.36.camel@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1014412325.1074.36.camel@callisto.yi.org>; from da-x@gmx.net on Fri, Feb 22, 2002 at 09:18:29PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 09:18:29PM +0000, Dan Aloni wrote:
> The attached patch implements C exceptions in the kernel, which *don't*
> depend on special support from the compiler. This is a 'request for
> comments'. The patch is very initial, should not be applied.
> 
> I actually got this code to work in the kernel:
> 
>         try {
>                 printk("TEST: before throwing \n");
>                 throw(1000);
>                 printk("TEST: won't run\n");
>         }
>         catch(unsigned long, value) {
>                 printk("TEST: caught: %ld\n", value);
>         } yrt;

Can they fall through multiple function calls? How do they jive with
preemtive scheduling? How much is the stack unwinding overhead?

Potentially this is very cool but I'm again appalled at the INSTANT
rejection seen here by kernel hackers, minor and major. Do NOT reject an
idea before you've thought it through. Do NOT reject an idea simply because
it is new.

Also, do not jump on the bandwagon BECAUSE it is new. But still - people
here should get a life if they get off on rejecting new stuff because it is
new.

Regards,

bert


-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc
