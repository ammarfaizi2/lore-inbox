Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbULPSz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbULPSz4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 13:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbULPSz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 13:55:56 -0500
Received: from dsl027-176-166.sfo1.dsl.speakeasy.net ([216.27.176.166]:32943
	"EHLO waste.org") by vger.kernel.org with ESMTP id S261979AbULPSzm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:55:42 -0500
Date: Thu, 16 Dec 2004 10:55:22 -0800
From: Matt Mackall <mpm@selenic.com>
To: Park Lee <parklee_sel@yahoo.com>
Cc: Paulo Marques <pmarques@grupopie.com>, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Issue on netconsole vs. Linux kernel oops
Message-ID: <20041216185522.GI2767@waste.org>
References: <41C1A31A.5070902@grupopie.com> <20041216184827.7357.qmail@web51501.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216184827.7357.qmail@web51501.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 10:48:27AM -0800, Park Lee wrote:
> Hi,
>   I'd like to use netconsole to send local Linux
> kernel's final messages (i.e. oops) to remote machine
> when the kernel crashes. 
>   Now I can successfully use a built-in netconsole to
> send some loacl kernel messages to the remote machine.
> (the parameter I send to local kernel on kernel
> command line is
> "netconsole=@192.168.0.2/,514@192.168.0.1/", I run
> syslogd in remote machine). For example, When the
> local kernel is booting, it will send a message
> "192.168.0.2 audit(1103247021.091:0): initialized" to
> remote machine through netconsole, and the syslogd on
> remote machine will write the message to
> /var/log/messages on remote machine.
>   What CONFUSE me most is that when the kernel
> crashes, there is NO message (oops) about the crash
> being wrote down by syslogd on remote machine to
> remote /var/log/messages file at all!! 
>   But in the mean time, We can see the outputs of
> tcpdump on the remote machine, they are some thing
> like the following:
> 
> 01:36:56.692877 IP 192.168.0.2.6665 >
> 192.168.0.1.syslog: UDP, length 48
> 01:36:56.692930 IP 192.168.0.2.6665 >
> 192.168.0.1.syslog: UDP, length 29
> 01:36:56.692982 IP 192.168.0.2.6665 >
> 192.168.0.1.syslog: UDP, length 15
> 01:36:56.693034 IP 192.168.0.2.6665 >
> 192.168.0.1.syslog: UDP, length 9
> 01:36:56.693086 IP 192.168.0.2.6665 >
> 192.168.0.1.syslog: UDP, length 16
> 01:36:56.693121 IP 192.168.0.2.6665 >
> 192.168.0.1.syslog: UDP, length 16
>    ... ...
> 
>   From these messages, we can see that the netconsole
> actually have sent the final messages (oops) to remote
> machine when the local kernel crashed. But there are
> no corresponding messages recorded by syslogd on
> remote machine to /var/log/messages.

>From your description, it sounds like syslogd is at fault. Try using
netcat on the remote machine.

-- 
Mathematics is the supreme nostalgia of our time.
