Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbULVSyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbULVSyR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 13:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbULVSyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 13:54:17 -0500
Received: from data.tikom.at ([193.108.212.253]:39818 "EHLO
	idefix1.limbo.tikom.at") by vger.kernel.org with ESMTP
	id S262018AbULVSyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 13:54:11 -0500
From: Simon Roscic <simon.roscic@chello.at>
To: linux-kernel@vger.kernel.org
Subject: [2.6] ethertap and af_inet.c assertion failures
Date: Wed, 22 Dec 2004 19:53:48 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Message-Id: <200412221953.48971.simon.roscic@chello.at>
X-MIMETrack: Itemize by SMTP Server on Adam/Mpreis(Release 5.0.11 |September 30, 2002) at
 22.12.2004 19:53:57,
	Serialize by Router on Adam/Mpreis(Release 5.0.11 |September 30, 2002) at
 22.12.2004 19:53:58,
	Serialize complete at 22.12.2004 19:53:58
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please cc me, as i´m not subscribed to lkml - thanks)

hi,

today i upgraded my kernel from 2.6.9-rc2 to 2.6.10-rc3-bk12, now i get the
following assertion failures while using the (closed source) phion vpn client,
the vpn client uses ethertap, there are no closed source kernel modules or the 
like:

KERNEL: assertion (!atomic_read(&sk->sk_wmem_alloc)) failed at 
net/ipv4/af_inet.c (150)

when the kernel prints out the above message the connection for the program 
using the vpn gets stuck - it happens very often if i use rdesktop, but it 
also happens when i just use ssh, so the bug may be triggered more often when 
there is more traffic over the vpn tunnel.

i tried with some other 2.6 kernel releases:

up to and including 2.6.9-rc2: no problem
2.6.9-rc3      does not boot on my machine
2.6.9-rc4      assertion failed as explained above
2.6.9        assertion failed as explained above

so it seems ethertap got broken somewhere post 2.6.9-rc2.
any ideas what got changed post 2.6.9-rc2 wich might cause this?

thanks for looking at this problem, if i can provide more information, just 
contact me.

bye,
 simon.
