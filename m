Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935964AbWK1SYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935964AbWK1SYg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 13:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936013AbWK1SYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 13:24:36 -0500
Received: from hera.kernel.org ([140.211.167.34]:26758 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S935964AbWK1SYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 13:24:36 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: A Big bug with ethernet card
Date: Tue, 28 Nov 2006 10:23:59 -0800
Organization: OSDL
Message-ID: <20061128102359.572a83f1@freekitty>
References: <20061128142950.67A461BF297@ws1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1164738240 22058 10.8.0.54 (28 Nov 2006 18:24:00 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 28 Nov 2006 18:24:00 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006 11:29:50 -0300
spynet@usa.com wrote:

> I find a bug in kernel 2.6.18.3
> 
> with ethernet card:
> 4.1 Ethernet card
>     -- Networking support
>         Networking options -->
>             Ethernet (1000 Mbit) -->
>                  Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller 
> 
> There are problems with ethernet card when booting to different system, e.g. from linux to M$ win - system is not able to connect to network. instead of re-boot you have to shutdown box and after that turn on. 
> 
> I running slackware 11 with kernel 2.6.18.3
> 
> root@segfault:/home/buzz# uname -a
> Linux segfault 2.6.18.3 #2 Tue Nov 28 08:10:19 BRST 2006 i686 athlon-4 i386 GNU/Linux
> 
> this problem have someone patch?
> 
> 
> 
> 
> 

The problem is that Linux leaves PHY powered off on shutdown, and windows is
too stupid to power it up.  This may be related to Wake On Lan, being default
off.

	http://bugzilla.kernel.org/show_bug.cgi?id=5204

-- 
Stephen Hemminger <shemminger@osdl.org>
