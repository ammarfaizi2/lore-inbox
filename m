Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVCPXuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVCPXuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbVCPXuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:50:24 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:29104 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261700AbVCPXuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:50:18 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: CPU hotplug on i386
Date: Thu, 17 Mar 2005 00:51:57 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       rusty@rustcorp.com.au
References: <20050316132151.GA2227@elf.ucw.cz> <20050316170945.GK21853@otto>
In-Reply-To: <20050316170945.GK21853@otto>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503170051.58579.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 16 of March 2005 18:09, Nathan Lynch wrote:
> On Wed, Mar 16, 2005 at 02:21:52PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > I tried to solve long-standing uglyness in swsusp cmp code by calling
> > cpu hotplug... only to find out that CONFIG_CPU_HOTPLUG is not
> > available on i386. Is there way to enable CPU_HOTPLUG on i386?
> 
> i386 cpu hotplug has been in -mm for a while.  Don't know when (if
> ever) it will get merged.

Thanks a lot for this hint! ;-)

Pavel, I've ported the basic i386 CPU hotplug stuff, without the sysfs
interface, to x86-64 (a cut'n'paste kind of work, mostly).  For now, I've
made HOTPLUG_CPU on x86-64 depend on SMP and SOFTWARE_SUSPEND and be set
automatically.

I'm going to test it together with your patch tomorrow.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
