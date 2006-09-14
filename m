Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWINPIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWINPIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWINPIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:08:48 -0400
Received: from twin.jikos.cz ([213.151.79.26]:59290 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1750742AbWINPIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:08:47 -0400
Date: Thu, 14 Sep 2006 17:08:21 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
In-Reply-To: <d120d5000609140758w7ba5cfdbs399d6831082e7cb4@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609141700250.2721@twin.jikos.cz>
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz> 
 <200609132200.51342.dtor@insightbb.com>  <Pine.LNX.4.64.0609141028540.22181@twin.jikos.cz>
  <d120d5000609140618h6e929883u2ed82d1cab677e57@mail.gmail.com> 
 <Pine.LNX.4.64.0609141635040.2721@twin.jikos.cz>
 <d120d5000609140758w7ba5cfdbs399d6831082e7cb4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006, Dmitry Torokhov wrote:

> Yes, this is much, much better. Could you please tell me if depth should 
> be a true depth or just an unique number? The reason I am asking is that 
> I hope to get rid of parent/child pointers in serio (they were 
> introduced when driver core could not handle recursive addition/removing 
> of devices on the same bus).

I am afraid you can't generate just any unique number to represent the 
lock class, as the lockdep validator fails if the class number is higher 
than MAX_LOCKDEP_SUBCLASSES, which is by default 8.

Regarding the patches - should I submit them upstream, or will you?

Thanks,

-- 
JiKos.
