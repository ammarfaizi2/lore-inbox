Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319320AbSIFSlU>; Fri, 6 Sep 2002 14:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319323AbSIFSlU>; Fri, 6 Sep 2002 14:41:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3719 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319320AbSIFSlS>;
	Fri, 6 Sep 2002 14:41:18 -0400
Date: Fri, 06 Sep 2002 11:38:29 -0700 (PDT)
Message-Id: <20020906.113829.65591342.davem@redhat.com>
To: manfred@colorfullife.com
Cc: haveblue@us.ibm.com, hadi@cyberus.ca, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D78F55C.4020207@colorfullife.com>
References: <3D78F55C.4020207@colorfullife.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Manfred Spraul <manfred@colorfullife.com>
   Date: Fri, 06 Sep 2002 20:35:08 +0200

   The second point was that interrupt mitigation must remain enabled, even 
   with NAPI: the automatic mitigation doesn't work with process space 
   limited loads (e.g. TCP: backlog queue is drained quickly, but the 
   system is busy processing the prequeue or receive queue)

Not true.  NAPI is in fact a %100 replacement for hw interrupt
mitigation strategies.  The cpu usage elimination afforded by
hw interrupt mitigation is also afforded by NAPI and even more
so by NAPI.
   
See Jamal's paper.

Franks a lot,
David S. Miller
davem@redhat.com
