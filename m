Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315631AbSFUBKG>; Thu, 20 Jun 2002 21:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315718AbSFUBKF>; Thu, 20 Jun 2002 21:10:05 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58300 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315631AbSFUBKE>;
	Thu, 20 Jun 2002 21:10:04 -0400
Date: Thu, 20 Jun 2002 18:03:58 -0700 (PDT)
Message-Id: <20020620.180358.33292945.davem@redhat.com>
To: george@mvista.com
Cc: rml@tech9.net, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace timer_bh with tasklet
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D126B28.16C88E2B@mvista.com>
References: <1024539334.917.110.camel@sinai>
	<20020619.192342.128398093.davem@redhat.com>
	<3D126B28.16C88E2B@mvista.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: george anzinger <george@mvista.com>
   Date: Thu, 20 Jun 2002 16:54:16 -0700
   
   Is the only network issue?  Is it possible that the network code
   uses bh_locking to protect against timers?  Moveing timers to
   softirqs would invalidate this sort of protection.  Is this an
   issue?

It is the whole issue.  We have to stop all timers while we run the
non-SMP safe protocol code.
