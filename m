Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261282AbTCFX2x>; Thu, 6 Mar 2003 18:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261277AbTCFX1Z>; Thu, 6 Mar 2003 18:27:25 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:64918 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S261258AbTCFX0q>; Thu, 6 Mar 2003 18:26:46 -0500
Message-Id: <200303062336.h26NatGi014423@locutus.cmf.nrl.navy.mil>
To: Werner Almesberger <wa@almesberger.net>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get() 
In-reply-to: Your message of "Thu, 06 Mar 2003 18:02:09 -0300."
             <20030306180209.C525@almesberger.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 06 Mar 2003 18:36:55 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030306180209.C525@almesberger.net>,Werner Almesberger writes:
>I don't think that would be much of a problem: ATMARP basically
>aggregates information, but does very little in terms of actual
>state transitions based on ATMARP/InARP messages. And IP doesn't
>mind a bit of reordering anyway. (Reconnecting an SVC in the

it would be a good idea to preserve the arrival order as much as possible
even though some protocols might not be overly sensitive.  just handling
the list as it appears on the recvq would eliminate the need for skb_migrate
and always keep the packets in the right order.
