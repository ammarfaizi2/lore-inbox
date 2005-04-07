Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262589AbVDGUVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbVDGUVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 16:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVDGUVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 16:21:24 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:29371 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262589AbVDGUVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 16:21:05 -0400
Date: Thu, 7 Apr 2005 16:20:59 -0400
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.11 can't disable CAD
Message-ID: <20050407202059.GA414@delft.aura.cs.cmu.edu>
Mail-Followup-To: "Richard B. Johnson" <linux-os@analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0504071102590.4871@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504071102590.4871@chaos.analogic.com>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 11:16:14AM -0400, Richard B. Johnson wrote:
> In the not-too distant past, one could disable Ctl-Alt-DEL.
> Can't do it anymore.
...
> Observe that reboot() returns 0 and `strace` understands what
> parameters were passed. The result is that, if I hit Ctl-Alt-Del,
> `init` will still execute the shutdown-order (INIT 0).

Actually, if CAD is enabled in the kernel, it will just reboot.
If CAD is disabled in the kernel a SIGINT is sent to pid 1 (/sbin/init).

So what you probably had in the not-too-distant past was a disabled CAD
in the kernel _and_ you had modified the following line in /etc/inittab,

    # What to do when CTRL-ALT-DEL is pressed.
    ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now

AFAIK this hasn't ever really changed.

Jan

