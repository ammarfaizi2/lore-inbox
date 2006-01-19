Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161254AbWASIA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161254AbWASIA3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 03:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbWASIA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 03:00:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9703 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161254AbWASIA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 03:00:29 -0500
Date: Wed, 18 Jan 2006 23:59:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch] halt_on_oops command line option
Message-Id: <20060118235958.6b466a86.akpm@osdl.org>
In-Reply-To: <20060119073951.GC21663@redhat.com>
References: <20060118232255.3814001b.akpm@osdl.org>
	<20060119073951.GC21663@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Wed, Jan 18, 2006 at 11:22:55PM -0800, Andrew Morton wrote:
>  > 
>  > How's this look?
>  > Attempt to fix the problem wherein people's oops reports scroll off the screen
>  > due to repeated oopsing or to oopses on other CPUs.
>  > 
>  > If this happens the user can reboot with the `halt_on_oops' option.  It will
>  > allow the first oopsing CPU to print an oops record just a single time.  Second
>  > oopsing attempts, or oopses on other CPUs will cause those CPUs to enter a
>  > tight loop.
> 
> seems a bit aggressive for UP.  Now if my sound driver oopses, I don't
> just lose sound, I lock up.  (That's why I made it a pause, not a halt
> in my earlier patch).
> 

Well I'm assuming people would only enable the option if they are
experiencing persistently-scrolling-off oopses.

We could make the boot option be number-of-seconds-to-pause I guess.  Do
you think it's really worth it?
