Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbTATKpF>; Mon, 20 Jan 2003 05:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbTATKpF>; Mon, 20 Jan 2003 05:45:05 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:39829 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S265457AbTATKpE>; Mon, 20 Jan 2003 05:45:04 -0500
Message-ID: <5352464.1043059747431.JavaMail.nobody@web11.us.oracle.com>
Date: Mon, 20 Jan 2003 02:49:07 -0800 (GMT-08:00)
From: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
To: mikpe@csd.uu.se
Subject: Re: Why kernel 2.5.58 only mounts / (not home etc)
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:

> On Sat, 18 Jan 2003 16:48:44 -0800 (GMT-08:00), Alessandro Suardi wrote:
> >As I reported in the same thread as the breakage of modules in 2.5.59,
> > module autoloading doesn't work for me since 2.5.58. Using Rusty's
> > module-init-tools 0.9.8 or 0.9.9-pre. Same utils work flawlessly under
> > 2.4.21-pre3.

[snip]

> If you're running a RedHat system, you'll also need the following
> patch to /etc/rc.d/rc.sysinit. Without it the kernel's modprobe and
> hotplug functionalities will be disabled by rc.sysinit.
> --- /etc/rc.d/rc.sysinit.~1~     2002-08-22 23:10:52.000000000 +0200
> +++ /etc/rc.d/rc.sysinit     2003-01-14 03:04:57.000000000 +0100
> @@ -334,7 +334,7 @@
>      IN_INITLOG=
>  fi
>  
> -if ! grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/ksyms ]; then
> +if ! grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/modules ]; then
>      USEMODULES=y
>  fi

Indeed, I'm running a RedHat 8.0 and this change to rc.sysinit brought me
 up and running again. Thanks !

--alessandro
