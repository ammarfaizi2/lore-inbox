Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280126AbRLLNwe>; Wed, 12 Dec 2001 08:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280056AbRLLNwY>; Wed, 12 Dec 2001 08:52:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7437 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280126AbRLLNwJ>; Wed, 12 Dec 2001 08:52:09 -0500
Subject: Re: Near CPUs ...
To: davidel@xmailserver.org (Davide Libenzi)
Date: Wed, 12 Dec 2001 14:01:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.40.0112111806100.1500-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Dec 11, 2001 06:32:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16E9x9-00019X-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> that lists metrics between CPUs, ie :
> 
> metric(I, J) = F(cpus_dmap[I][J])
> 
> and this is the easy part.
> How to detect CPUs that are "near" ( on the same bus/mb ) on x86/ia64 hardware ?
> Is the MP configuration data structured in a way that makes you understand
> this mapping, ie :

The MP 1.1/1.4 mappings have no information on memory or locality. The ACPI
stuff seems to have the same limitations. The ACPI one does correctly
describe hyperthreading pairs (two execution units per die) - but while they
are "closer" they are also less efficient than two seperate cpus for most
tasks.
