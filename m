Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbTEaIr6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 04:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbTEaIr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 04:47:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24758 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264233AbTEaIr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 04:47:57 -0400
Date: Sat, 31 May 2003 01:58:29 -0700 (PDT)
Message-Id: <20030531.015829.98871441.davem@redhat.com>
To: willy@w.ods.org
Cc: scrosby@cs.rice.edu, alexander.riesen@synopsys.COM,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030531085612.GE21673@alpha.home.local>
References: <20030531080205.GA776@pcw.home.local>
	<20030531.011210.34750891.davem@redhat.com>
	<20030531085612.GE21673@alpha.home.local>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Willy Tarreau <willy@w.ods.org>
   Date: Sat, 31 May 2003 10:56:12 +0200

   Considering that the Alpha and the UltraSparc can issue up to 4
   instruction per cycle,

Ultrasparc only has 2 integer units.  So it really can only do 2
integer operations per cycle.  GCC is giving it an optimal schedule
for -mtune=ultrasparc, I know because I wrote that instruction
scheduler :-)

You can get 4 issue if you're doing floating point stuff.

I believe the current generation Alpha has 3 integer units.
GCC should be doing a good job there too.
