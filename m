Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318087AbSFTBka>; Wed, 19 Jun 2002 21:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318086AbSFTBk3>; Wed, 19 Jun 2002 21:40:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56753 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318085AbSFTBk2>;
	Wed, 19 Jun 2002 21:40:28 -0400
Date: Wed, 19 Jun 2002 18:34:32 -0700 (PDT)
Message-Id: <20020619.183432.27032473.davem@redhat.com>
To: george@mvista.com
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace timer_bh with tasklet
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D11245F.DB13A07C@mvista.com>
References: <200206181829.WAA13590@sex.inr.ac.ru>
	<3D11245F.DB13A07C@mvista.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: george anzinger <george@mvista.com>
   Date: Wed, 19 Jun 2002 17:39:59 -0700

   At this point I am only aware of one place in the kernel where timers and 
   other BH code interact, that being deliver_to_old_ones() in net/core/dev.c.

Are you absolutely sure?  What about serial drivers and the TTY layer?
Have you audited all of that code too?  What about SCSI_BH?  What
about IMMEDIATE_BH, TQUEUE_BH?  Do they interact non-trivially with
timers too?

Alexey is right, there needs to be a real audit here before this
patch may be considered.
