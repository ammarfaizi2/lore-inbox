Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbULRQn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbULRQn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 11:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbULRQn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 11:43:26 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:31361 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261190AbULRQmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 11:42:45 -0500
Subject: Re: Re[2]: do_IRQ: stack overflow: 872..
From: Bart De Schuymer <bdschuym@pandora.be>
To: Crazy AMD K7 <snort2004@mail.ru>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <1421293830.20041218190742@mail.ru>
References: <1131604877.20041218092730@mail.ru.suse.lists.linux.kernel>
	 <p73zn0ccaee.fsf@verdi.suse.de>
	 <1103368330.3566.15.camel@localhost.localdomain>
	 <20041218111420.GE338@wotan.suse.de>
	 <1103370690.3566.33.camel@localhost.localdomain>
	 <20041218135320.GA10030@wotan.suse.de>  <1421293830.20041218190742@mail.ru>
Content-Type: text/plain
Date: Sat, 18 Dec 2004 17:46:20 +0100
Message-Id: <1103388380.3557.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op za, 18-12-2004 te 19:07 +0300, schreef Crazy AMD K7:
> > Note to the original poster: when you report a bug with a patched
> > kernel always mention it.
> I have mentioned earlier and Bart knows it.
> 
> I use 2.4.28
> + ebtables-brnf-8_vs_2.4.28.diff
> + U32 patch from patch-o-matic-ng-20040621.tar.bz2
> + patch for br_netfilter.c made by Bart to find out why kernel panic happens(it was a few
>   letters ago)
>   All patches has applies cleanly.
>   U32 doesn't affect on br_netfilter.c

Sorry, I don't know the ip_queue mechanism and I don't know what could
possibly go wrong.
All we know is that you no longer have kernel panics with the simple
patch I gave you (which just drops packets when a kernel panic would
happen otherwise, and tells about this with a printk). However, you
state there are no entries in your syslog that tell about this dropping.
Is your syslog working right? Do you have a console open on which kernel
messages get printed?

I still secretly suspect the snort code of inserting packets back into
the kernel that don't have an output device (I don't know if that's
possible, though).

cheers,
Bart


