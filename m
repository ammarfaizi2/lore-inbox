Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267989AbUHKLlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267989AbUHKLlY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 07:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268024AbUHKLlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 07:41:24 -0400
Received: from users.linvision.com ([62.58.92.114]:28610 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S267989AbUHKLlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 07:41:01 -0400
Date: Wed, 11 Aug 2004 13:41:00 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Paul Jackson <pj@sgi.com>, Eric Masson <cool_kid@future-ericsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fork and Exec a process within the kernel
Message-ID: <20040811114100.GB10047@harddisk-recovery.nl>
References: <4117E68A.4090701@future-ericsoft.com> <20040809161003.554a5de1.pj@sgi.com> <4118E822.3000303@future-ericsoft.com> <20040810092116.7dfe118c.pj@sgi.com> <Pine.LNX.4.53.0408101456260.13579@chaos> <20040811095139.GA10047@harddisk-recovery.com> <Pine.LNX.4.53.0408110721540.15879@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0408110721540.15879@chaos>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 07:24:42AM -0400, Richard B. Johnson wrote:
> On Wed, 11 Aug 2004, Erik Mouw wrote:
> > Please don't mislead newbies, Richard. /dev/console is NOT a link to
> > /dev/tty0, it's a completely different device:
> >
> > erik@abra2:~ >ls -l /dev/console
> > crw-------    1 root     tty        5,   1 Apr  7 09:13 /dev/console
> > erik@abra2:~ >ls -l /dev/tty0
> > crw-------    1 root     tty        4,   0 Feb 10  2000 /dev/tty0
> >
> 
> Bullshit. I know how to use `file`.
> 
> Script started on Wed Aug 11 07:21:39 2004
> # file /dev/console
> /dev/console: symbolic link to /dev/tty0

It might be a symlink on your machine, but that doesn't mean it's the
right way. For almost 7 years, /dev/console is a separate device, not a
symlink. Here's the relevant section from Documentation/devices.txt:

  The console device, /dev/console, is the device to which system
  messages should be sent, and on which logins should be permitted in
  single-user mode.  Starting with Linux 2.1.71, /dev/console is managed
  by the kernel; for previous versions it should be a symbolic link to
  either /dev/tty0, a specific virtual console such as /dev/tty1, or to
  a serial port primary (tty*, not cu*) device, depending on the
  configuration of the system.

Linux-2.1.71 was released on December 4, 1997. In your signature you
claim to run linux-2.4.26. Please update your system.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
