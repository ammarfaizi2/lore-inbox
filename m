Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318090AbSFTCBO>; Wed, 19 Jun 2002 22:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318091AbSFTCBN>; Wed, 19 Jun 2002 22:01:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4018 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318090AbSFTCBM>;
	Wed, 19 Jun 2002 22:01:12 -0400
Date: Wed, 19 Jun 2002 18:55:14 -0700 (PDT)
Message-Id: <20020619.185514.52961715.davem@redhat.com>
To: rml@tech9.net
Cc: george@mvista.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace timer_bh with tasklet
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1024538005.922.70.camel@sinai>
References: <3D11245F.DB13A07C@mvista.com>
	<20020619.183432.27032473.davem@redhat.com>
	<1024538005.922.70.camel@sinai>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Robert Love <rml@tech9.net>
   Date: 19 Jun 2002 18:53:25 -0700
   
   SCSH_BH is gone in 2.5.23.  Matthew Wilcox has a patch to remove
   IMMEDIATE_BH.
   
   TIMER_BH is the only BH left as far as I know.
   
What about all of the serial driver BHs?  You keep avoiding this
issue.

Also, when people remove *_BH they should remove the define in
include/linux/interrupt.h Why people leave this there is beyond me, it
only causes confusion when people try to figure out what the current
state of affairs is.
