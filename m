Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSKHREM>; Fri, 8 Nov 2002 12:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbSKHREM>; Fri, 8 Nov 2002 12:04:12 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:28060 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262210AbSKHREL>; Fri, 8 Nov 2002 12:04:11 -0500
Subject: Re: IDE and possibly ext3 problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Helmut Apfelholz <helmutapfel@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021107065208.91462.qmail@web14102.mail.yahoo.com>
References: <20021107065208.91462.qmail@web14102.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Nov 2002 17:34:19 +0000
Message-Id: <1036776859.16626.41.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 06:52, Helmut Apfelholz wrote:
> b3 kernel: hdm: timeout waiting for DMA
> b3 kernel: ide_dmaproc: chipset supported
> ide_dma_timeout func only: 14
> b3 kernel: hdm: status timeout: status=0xd0 { Busy }
> b3 kernel: hdm: drive not ready for command

Your disk went offline somehow.

> and the server start to generate increasingly higher
> loads as it waits for the disk. With ac kernel we were
> forced to reset the machine. After it came up, we've
> noticed in the logs:

Looks like not everything got written before the crash  Not impossible
in writeback mode especially with the IDE controller caches involved.

> and see no errors. Ah, it looks like hdm disk isn't in
> the dmesg output anymore:

Maybe it died completely at that point ?


