Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWCRVgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWCRVgz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 16:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWCRVgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 16:36:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25766 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750789AbWCRVgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 16:36:53 -0500
Date: Sat, 18 Mar 2006 13:33:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       trini@kernel.crashing.org
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
Message-Id: <20060318133351.41baa992.akpm@osdl.org>
In-Reply-To: <9a8748490603181326p12f35665y4504e77561f3c99@mail.gmail.com>
References: <20060318142827.419018000@localhost.localdomain>
	<20060318142830.607556000@localhost.localdomain>
	<20060318120728.63cbad54.akpm@osdl.org>
	<1142712975.17279.131.camel@localhost.localdomain>
	<20060318123102.7d8c048a.akpm@osdl.org>
	<1142714332.17279.148.camel@localhost.localdomain>
	<20060318130925.616d11c5.akpm@osdl.org>
	<9a8748490603181326p12f35665y4504e77561f3c99@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>
> > It would be strange to set an alarm for 0xffffffff seconds in the future
>  > but yeah, unless we can point at a reason why nobody could have ever been
>  > doing that, we should turn this into permanent, documented behaviour of
>  > Linux 2.6 and earlier, I'm afraid.
>  >
> 
>  How about 0xffffffff seconds into the future being the same as 136
>  years (unless I botched the math)... That means that if any Linux
>  application ever did that it's still waiting for the alarm and will be
>  for at least another century...
>  I'd say that makes it pretty certain that noone are doing or have been
>  doing that without spotting the problem somehow - apps with such a bug
>  are unlikely to be in production and actually working correctly.

We just don't know.  People do all sorts of things.

How about this?

	$ cat /etc/my-expensive-app.conf
	#
	# Interval polling timer.  Set this to -1 to disable
	#
	interval_polling_timer=-1

We just don't know.
