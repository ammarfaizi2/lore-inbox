Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268125AbTCCAhM>; Sun, 2 Mar 2003 19:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268137AbTCCAhM>; Sun, 2 Mar 2003 19:37:12 -0500
Received: from mail1.bluewin.ch ([195.186.1.74]:20961 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id <S268125AbTCCAhL>;
	Sun, 2 Mar 2003 19:37:11 -0500
Date: Mon, 3 Mar 2003 01:39:40 +0100
From: Roger Luethi <rl@hellgate.ch>
To: bert hubert <ahu@ds9a.nl>, Nigel Cunningham <ncunningham@clear.net.nz>,
       Pavel Machek <pavel@ucw.cz>, Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: S4bios support for 2.5.63
Message-ID: <20030303003940.GA13036@k3.hellgate.ch>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Nigel Cunningham <ncunningham@clear.net.nz>,
	Pavel Machek <pavel@ucw.cz>, Andrew Grover <andrew.grover@intel.com>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030226211347.GA14903@elf.ucw.cz> <20030302133138.GA27031@outpost.ds9a.nl> <1046630641.3610.13.camel@laptop-linux.cunninghams> <20030302202118.GA2201@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030302202118.GA2201@outpost.ds9a.nl>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.63 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Mar 2003 21:21:18 +0100, bert hubert wrote:
> In 2.5.63bk5 I get a BUG on drivers/ide/ide-disk.c:1557:
> 
> 
>         BUG_ON (HWGROUP(drive)->handler);
> 

That problem has been around for a while. I reported it for 2.5.59 which
just happened to be the first 2.5 kernel I tested with swsuspend.

I'm seeing the bug every time I try swsuspend on 2.5. The same Vanilla
kernels seem to work for other people, though.

The only thing that came up at the time was a suggestion to replace BUG_ON
with while (which I didn't try because I'd like to keep my data).

Roger
