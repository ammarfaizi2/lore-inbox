Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUCKKUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 05:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUCKKUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 05:20:31 -0500
Received: from gate.firmix.at ([80.109.18.208]:21153 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S261168AbUCKKU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 05:20:29 -0500
Subject: Re: Kernel panic with SLES8.0
From: Bernd Petrovitsch <bernd@firmix.at>
To: Psm.Swamiji@Sun.COM
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40501696.2050508@Sun.COM>
References: <404F5FC1.7070207@Sun.COM> <404F750B.4040100@Sun.COM>
	 <1078922086.23064.7.camel@tara.firmix.at>  <40501696.2050508@Sun.COM>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1079000425.21131.63.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 11:20:25 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Don, 2004-03-11 at 08:34, Sesha Muneendra Swameejee Panda wrote:
> Bernd Petrovitsch wrote:
> > On Mit, 2004-03-10 at 21:05, Sesha Muneendra Swameejee Panda wrote:
> > [...]
> >>Sesha Muneendra Swameejee Panda wrote:
> > [...]
> >>>I have installed the SLES8.0 on a LX50 server. The installation went
> >>
> > 
> > You should probably go to SuSE with the bug report since it is theirs
> > product.
> 
> As I am a new bite to linux world , I don't know the procedure to file bugs.

First I assume that SLES-8.0 means "Suse Linux Enterprsie Server 8.0".

> Can you please give the procedure or contact info of Suse to file the 
> bug report.

Their website is http://www.suse.com/. I don't know where exactly you
are expected to ask that kind of questions or file bug reports.

In the current case the kernel is not able to mount the root file system
(where pretty much the very important executables and libraries are
around).
This problem has actually nothing to do with the kernel per se since he
simply reports that (which is actually the second reason why the
question is somewhta off-topic on the LKML).
Usually that means that at least one of the follwoign does not work:
-) the driver for IDE, SCSI or wherever the root filesystem is to be 
   found is not available
-) the driver of the filesystem which is used on the root filesystem is
   not available.
-) some part of the hardware is broken - this can be the SCSI/IDE/...
   controller itself, the disk, cables in between, etc.
The list is not complete - just what I would primarily expect.

Especially the
----  snip  ----
aic7xxx_abort returnss 0x2002
scsi: device set offline - not ready or command retry failed after bus 
reset: ho
----  snip  ----
make me think that either the Adaptec controller or the disk (or the
cable in between) have a serious hardware problem. But I'm no export in
that area ....

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

