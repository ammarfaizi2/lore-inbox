Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751657AbWANGdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbWANGdN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 01:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbWANGdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 01:33:13 -0500
Received: from xenotime.net ([66.160.160.81]:40072 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751650AbWANGdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 01:33:13 -0500
Date: Fri, 13 Jan 2006 22:33:09 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: BuraphaLinux Server <buraphalinuxserver@gmail.com>
Cc: linux-kernel@vger.kernel.org, okir@monad.swb.de
Subject: Re: nlm_udpport vs. udpport vs lockd.nlm_udpport vs etc.
Message-Id: <20060113223309.011188f1.rdunlap@xenotime.net>
In-Reply-To: <5d75f4610601132130s4870d9eaq9261450905d6b888@mail.gmail.com>
References: <5d75f4610601132130s4870d9eaq9261450905d6b888@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2006 12:30:18 +0700 BuraphaLinux Server wrote:

> I am attempting to setup a firewall for an NFS v3 server.  I need to know where
> the lockd ports will be.  I have added an append line to my lilo.conf
> that looks like
> this, and it was working in the 2.4 kernels:
> 
> append="lockd.nlm_udpport=32768 lockd.nlm_tcpport=32768"
> 
> I am using kernel 2.6.15 from ftp.kernel.org and I am trying to learn
> what to do.
> But the file fs/lockd/svc.c seems to want this without the 'lock.' in front.
> But the file Documentation/kernel-parameters.txt suggests
> lockd.udpport and lockd.tcpport (no "nlm_").
 
OK, I'll send a patch for that this weekend.  It should be:

  lockd.nlm_udpport=N  lockd.nlm_tcpport=M

when built into the kernel
image.  If built as loadable modules, it is just
  modprobe lockd nlm_udpport=N nlm_tcpport=M


> 1.  Why do the files in the kernel disagree with each other?

No idea.

> 2.  What do I really need on my append="" line, or is there some other
>      way to set this now?
> 3.  Should I hardcode the ports in the kernel source code and recompile?

If above doesn't work, it would be much better if you filed a bug on it.

---
~Randy
