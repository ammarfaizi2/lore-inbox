Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbSJaRkZ>; Thu, 31 Oct 2002 12:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265234AbSJaRkW>; Thu, 31 Oct 2002 12:40:22 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:32674 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265228AbSJaRkV>;
	Thu, 31 Oct 2002 12:40:21 -0500
Subject: Disallowing unlock operations during the NFSv3 grace period
To: nfs@lists.sourceforge.net
Cc: Linux-Kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OF9E97B7B9.73264A1D-ON87256C63.00610AF7@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Thu, 31 Oct 2002 09:46:33 -0800
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0|September 26, 2002) at
 10/31/2002 10:46:34
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was wondering if any of the developers can explain why we disallow unlock
operations during the grace period of a NFSv3 server?
(fs/lockd/*)

I think we should allow unlock operations during the grace period and only
filter lock operations. This becomes specially important in
clustered NAS heads where some of the nodes may enter the grace period
during cluster recovery in addition to node reboots.

The side effect of rejecting unlock during the grace period in clustered
NAS heads is that unlocks are unfairly delayed when they happen
to hit the NAS head cluster nodes when they are recovering from a node
failure.


Juan

