Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270472AbTGZQk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 12:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270470AbTGZQkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 12:40:43 -0400
Received: from hera.kernel.org ([63.209.29.2]:700 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S270468AbTGZQjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 12:39:16 -0400
To: linux-kernel@vger.kernel.org
From: OSDL <torvalds@osdl.org>
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Date: Sat, 26 Jul 2003 09:54:09 -0700
Organization: OSDL
Message-ID: <bfubnh$vil$1@build.pdx.osdl.net>
References: <200307262036.13989.arvidjaar@mail.ru>
Reply-To: torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: build.pdx.osdl.net 1059238449 32341 172.20.1.2 (26 Jul 2003 16:54:09 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Sat, 26 Jul 2003 16:54:09 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
> 
> As far as I can tell sysfs device names include logical bus numbers which
> means, if hardware is added or removed it is possible names do change.

Absolutely.

The fact is, the kernel _cannot_ give persistent names to devices, because
it is simply not a problem that is solvable with the resources the kernel
has access to.

For persistent naming, you need (a) user policy and (b) stable storage,
neither of which the kernel has. 

GregKH has a "udev" setup that plugs into /sbin/hotplug and uses sysfs
to implement stable naming. So sysfs is part of the picture, but it's
not the whole answer.

> the point is - I want to create aliases that would point to specific
> slots. I.e. when I plug USB memory stick in upper slot on front panel I'd
> like to always create the same device alias for it.

Right: what you're asking for is persistent per-device user policy.

                Linus 
