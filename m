Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318089AbSFTBxg>; Wed, 19 Jun 2002 21:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318090AbSFTBxf>; Wed, 19 Jun 2002 21:53:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:64241 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318089AbSFTBxc>; Wed, 19 Jun 2002 21:53:32 -0400
Subject: Re: [PATCH] Replace timer_bh with tasklet
From: Robert Love <rml@tech9.net>
To: "David S. Miller" <davem@redhat.com>
Cc: george@mvista.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
In-Reply-To: <20020619.183432.27032473.davem@redhat.com>
References: <200206181829.WAA13590@sex.inr.ac.ru>
	<3D11245F.DB13A07C@mvista.com>  <20020619.183432.27032473.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Jun 2002 18:53:25 -0700
Message-Id: <1024538005.922.70.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-19 at 18:34, David S. Miller wrote:

> Are you absolutely sure?  What about serial drivers and the TTY layer?
> Have you audited all of that code too?  What about SCSI_BH?  What
> about IMMEDIATE_BH, TQUEUE_BH?  Do they interact non-trivially with
> timers too?

SCSH_BH is gone in 2.5.23.  Matthew Wilcox has a patch to remove
IMMEDIATE_BH.

TIMER_BH is the only BH left as far as I know.

So the needed synchronization, if any, is against the other softirqs.

	Robert Love

