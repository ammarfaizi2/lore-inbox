Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbTDPQ3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbTDPQ3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:29:49 -0400
Received: from 217-126-36-165.uc.nombres.ttd.es ([217.126.36.165]:1232 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id S264469AbTDPQ3r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:29:47 -0400
Date: Wed, 16 Apr 2003 18:39:54 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>, Eric Mudama <eric_mudama@maxtor.com>
cc: hps@intermeta.de
Subject: RE: [2.4.21-pre7-ac1] IDE Warning when booting
In-Reply-To: <785F348679A4D5119A0C009027DE33C102E0D12A@mcoexc04.mlm.maxtor.com>
Message-ID: <Pine.LNX.4.44.0304161829510.4806-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Apr 2003, Mudama, Eric wrote:

> Was thinking...
> 
> Do you know what attempted multi count was as an argument to SET MULTIPLE
> MODE?

This are the parametres rc.sysinit sets just before switching to the
selected run level:

# cat /etc/sysconfig/harddisks | grep -v "^#"
USE_DMA=0 MULTIPLE_IO=16
EIDE_32BIT=3
LOOKAHEAD=1
EXTRA_PARAMS="-u1"

I twicked them to improve performance, but the behaviour was the same 
(poor performance and ide=nodma to be able to boot) before these 
modifications. So, maybe they are wrong, but no the cause of the problem.

> The specification says powers of 2 from 2 to 128 are all valid, however,
> most drives I have looked at only support <= 16.  This has some sort of
> historical oem reason for being the max and I haven't worked here long
> enough to know the 'why'.

Sorry, I do not know either.

> However, the ID block also reports the maximum multiple count in word 47
> bits 7..0, so if that was non zero, the drive shouldn't abort it.
> 
> The engineer sitting next to me (former quantum employee) is reasonably
> certain that the drive shouldn't be aborting that command.
> 
> It'd be interesting to look at the ID block and the task file for that
> command that the drive aborted.

How can I get this information?

Pau

