Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbULPSpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbULPSpS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 13:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbULPSpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 13:45:18 -0500
Received: from dsl027-176-166.sfo1.dsl.speakeasy.net ([216.27.176.166]:26284
	"EHLO waste.org") by vger.kernel.org with ESMTP id S261977AbULPSpL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:45:11 -0500
Date: Thu, 16 Dec 2004 10:44:38 -0800
From: Matt Mackall <mpm@selenic.com>
To: Park Lee <parklee_sel@yahoo.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: What's the matter with build-in netconsole?
Message-ID: <20041216184438.GH2767@waste.org>
References: <20041216143537.41770.qmail@web51502.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216143537.41770.qmail@web51502.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 06:35:37AM -0800, Park Lee wrote:
> Hi,
>   I try to use netconsole to keep Linux kernel oops to
> another machine. I've compiled netconsole into the
> kernel (i.e. select CONFIG_NETCONSOLE=y, when run
> 'make menuconfig'). 
>   After that, I put
> "netconsole=@/,514@192.168.0.1/00:02:3F:03:D2:59"
> (which is described in
> /usr/src/linux/Documentation/networking/netconsole.txt)

You have to configure a source IP address for built-in netconsole, as
interfaces normally don't have addresses assigned to them until init.

> to the kernel command line as provided by grub and
> rerun my machine with the new compiled kernel.
>   But then, when the system is booting, it shows the
> following message:
> 
> ... ...
> Uncompressing Linux... Ok, booting the kernel.
> audit(1103234064.4294965842:0): initialized
> netconsole: eth0 doesn't exist, aborting.
> ... ...
> 
>   Then, What's the matter with the build-in
> netconsole? Have I misconfiged the netconsole? and How
> to really run build-in netconsole?

Is your network driver built in? Is it eth0 (you let netconsole use
the default)? Is it initialized before netconsole? Please send your
_entire_ dmesg.

-- 
Mathematics is the supreme nostalgia of our time.
