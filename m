Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275387AbTHGO74 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275378AbTHGO57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:57:59 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:38275 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S275343AbTHGO47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:56:59 -0400
Subject: Re: Loading Pentium III microcode under Linux - catch 22!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Rankin <rankincj@yahoo.com>
Cc: tigran@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030807143831.73389.qmail@web40603.mail.yahoo.com>
References: <20030807143831.73389.qmail@web40603.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060267992.3168.70.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 15:53:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-07 at 15:38, Chris Rankin wrote:
> July 2000, and my current BIOS just doesn't have any
> microcode for them. Without the update, I used to come
> back at the end of the day, switch on the KVM and be
> unable to use the keyboard and mouse.

Sounds believable

> Anyway, I wasn't aware that Intel had released a
> changelist for their microcode updates. Goodness knows
> what bugs they're fixing.

Generally speaking its the ones that end  "Can be worked around by
the BIOS" in the big list of errata. Some of those are however
other things like setting timing registers or turning off features
via semi-secret mtrr registers

> memory), and CPU malfunction is the leading candidate
> explanation. I have already replaced the 300W PSU with
> a 400W one and tested the memory.

Ok

> Yes, that's the "catch-22" bit. I was originally
> thinking about either a bootstrapping floppy disk, or
> maybe hacking some code into the boot-up sequence
> itself.
> 
> > it can load it very early after that from initrd.
> 
> OK, I'll look into that.

Looking at it you can do it in initrd fine, or you can do it
as the first thing you do once the real root fs is mounted
from init's scripts (/etc/rc.sysinit normally)

