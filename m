Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbTLQTeN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 14:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbTLQTeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 14:34:13 -0500
Received: from tantale.fifi.org ([216.27.190.146]:43401 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S264530AbTLQTeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 14:34:09 -0500
To: "Jeremy Kusnetz" <JKusnetz@nrtc.org>
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23 is freezing my systems hard after 24-48 hours
References: <F7F4B5EA9EBD414D8A0091E80389450513C09F@exchange.nrtc.coop>
From: Philippe Troin <phil@fifi.org>
Date: 17 Dec 2003 11:34:02 -0800
In-Reply-To: <F7F4B5EA9EBD414D8A0091E80389450513C09F@exchange.nrtc.coop>
Message-ID: <874qvzw85x.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeremy Kusnetz" <JKusnetz@nrtc.org> writes:

> > Please try the NMI oopser. 
> 
> Okay, the box just crashed.  It's acting differently then the previous crashes.  The previous crashed would lock up hard, no network, no output to screen, no sysrq.  I don't know if the NMI-watchdog is what's letting it get this far.
> 
> This is the output to screen:
> 
> BUG IN DYNAMIC LINKER ld.so: ../sysdeps/i386/dl-machine.h: 391: elf_machine_lazy_rel: Assertion `((reloc->r_info) & 0xff) == 7' failed!
> 
> It just streams this error over and over on the console, and you also get this message back if you attempt to ssh to the box.
> 
> Again, I don't know if this is the same thing that was happening before, but all my other boxes that are running 2.4.22 have been doing so without any issue for about 5 days now, this one died after 50 hours.
> 
> Also I was getting this in syslog:
> 
> Dec 17 11:26:27 realserver6 inetd[92]: pid 4152: exit status 127
>  Dec 17 11:26:48 realserver6 inetd[92]: pid 4217: exit status 127
>  Dec 17 11:27:27 realserver6 inetd[92]: pid 4375: exit status 127
>  Dec 17 11:27:48 realserver6 inetd[92]: pid 4450: exit status 127
>  Dec 17 11:27:49 realserver6 inetd[92]: pid 4462: exit status 127
>  Dec 17 11:27:52 realserver6 init: Id "c1" respawning too fast: disabled for 5 minutes
>  Dec 17 11:27:52 realserver6 inetd[92]: pid 4480: exit status 127
>  Dec 17 11:27:52 realserver6 inetd[92]: pid 4481: exit status 127
>  Dec 17 11:28:27 realserver6 inetd[92]: pid 4591: exit status 127
> 
> 
> Again I've never seen this with other kernels, yet everything else the same.

I have seen no crashes or freezes after three days of running 2.4.23 +
the linux-2.4.23-uv1 patch. I am not using ipchains, so maybe there's
something else in the uv1 patch that fixes the freeze?

Phil.
