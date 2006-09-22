Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWIVVUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWIVVUy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 17:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWIVVUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 17:20:54 -0400
Received: from earth.cora.nwra.com ([65.125.157.180]:8381 "EHLO
	earth.cora.nwra.com") by vger.kernel.org with ESMTP id S932178AbWIVVUx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 17:20:53 -0400
Message-ID: <4514539D.8010704@cora.nwra.com>
Date: Fri, 22 Sep 2006 15:20:29 -0600
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to debug random bus errors?
References: <ef15fm$uhs$1@sea.gmane.org> <Pine.LNX.4.64.0609221225500.4388@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609221225500.4388@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 22 Sep 2006, Orion Poplawski wrote:
>> We're seeing programs die with "bus error" (SIGBUS) randomly on a dual
>> processor Opteron machine.  I've run memtest86+ and cpuburn stress tests with
>> no failure.  gdb on a core file seems uninteresting.  Is there some way to
>> trace the kernel to try to get more insight?
> 
> Which kernel?
> 

Sorry, 2.6.17-1.2142_FC4smp, so fairly recent.

> Other than that, does it tend to happen to the same particular program? It 
> might just be a user space bug that needs a specific set of things to 
> happen. Some of those bugs go away when you disable address space 
> randomization etc, since they can depend on just pure luck (or rather, 
> lack there-of).

So far just one program.  Forgot about address space randomization, may 
need to look into turning that off to help debugging.

Thanks!

-- 
Orion Poplawski
System Administrator                  303-415-9701 x222
NWRA/CoRA Division                    FAX: 303-415-9702
3380 Mitchell Lane                  orion@cora.nwra.com
Boulder, CO 80301              http://www.cora.nwra.com
