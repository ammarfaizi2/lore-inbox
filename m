Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSHFRRF>; Tue, 6 Aug 2002 13:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314083AbSHFRRE>; Tue, 6 Aug 2002 13:17:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20943 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314077AbSHFRRD>;
	Tue, 6 Aug 2002 13:17:03 -0400
Date: Tue, 06 Aug 2002 10:07:49 -0700 (PDT)
Message-Id: <20020806.100749.21530590.davem@redhat.com>
To: maxk@qualcomm.com
Cc: jajcus@bnet.pl, linux-kernel@vger.kernel.org
Subject: Re: "new style" netdevice allocation patch for TUN driver (2.4.18
 kernel)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20020806094253.09734790@mail1.qualcomm.com>
References: <5.1.0.14.2.20020802164143.04da52f8@mail1.qualcomm.com>
	<20020803140858.GA5314@nic.nigdzie>
	<5.1.0.14.2.20020806094253.09734790@mail1.qualcomm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
   Date: Tue, 06 Aug 2002 10:07:49 -0700
   
   Dave, how about this
   
   --- net/core/dev.c.orig Mon Aug  5 21:48:54 2002
   +++ net/core/dev.c      Mon Aug  5 21:54:01 2002
   @@ -2577,6 +2577,11 @@

First, the call-chain notifiers are probably not safe
to run without rtnl_lock held.

Second, why not just fix the bug instead of applying band-aids
to device unregistry?  I know it's nice in that it allows you
to configure devices some more, but it doesn't make the real
problem go away.
