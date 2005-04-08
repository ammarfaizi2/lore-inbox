Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262833AbVDHNSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbVDHNSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 09:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVDHNLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 09:11:32 -0400
Received: from nevyn.them.org ([66.93.172.17]:12764 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262805AbVDHNF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 09:05:29 -0400
Date: Fri, 8 Apr 2005 09:05:22 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.11 can't disable CAD
Message-ID: <20050408130522.GA32099@nevyn.them.org>
Mail-Followup-To: "Richard B. Johnson" <linux-os@analogic.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0504071102590.4871@chaos.analogic.com> <20050407202059.GA414@delft.aura.cs.cmu.edu> <Pine.LNX.4.61.0504071639060.4895@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504071639060.4895@chaos.analogic.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 04:50:32PM -0400, Richard B. Johnson wrote:
> On Thu, 7 Apr 2005, Jan Harkes wrote:
> 
> >On Thu, Apr 07, 2005 at 11:16:14AM -0400, Richard B. Johnson wrote:
> >>In the not-too distant past, one could disable Ctl-Alt-DEL.
> >>Can't do it anymore.
> >...
> >>Observe that reboot() returns 0 and `strace` understands what
> >>parameters were passed. The result is that, if I hit Ctl-Alt-Del,
> >>`init` will still execute the shutdown-order (INIT 0).
> >
> >Actually, if CAD is enabled in the kernel, it will just reboot.
> >If CAD is disabled in the kernel a SIGINT is sent to pid 1 (/sbin/init).
> >
> 
> No, that's not how it ever worked. There are parameters that are
> available in the reboot-system call that define the operation that
> will occur when the 3-finger salute occurs.
> 
> Execute man 2 reboot.

Take your own advice.  From the man page:

       LINUX_REBOOT_CMD_CAD_ON
              (RB_ENABLE_CAD, 0x89abcdef).  CAD is enabled.  This means
              that the CAD keystroke will immediately cause the action
              associated with LINUX_REBOOT_CMD_RESTART.

       LINUX_REBOOT_CMD_CAD_OFF
              (RB_DISABLE_CAD, 0).  CAD is disabled. This means that the CAD
              keystroke will cause a SIGINT signal to be sent to init
              (process 1), whereupon this process may decide upon a
              proper action (maybe: kill all processes, sync, reboot).

-- 
Daniel Jacobowitz
CodeSourcery, LLC
