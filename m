Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWIZMVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWIZMVB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 08:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWIZMVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 08:21:01 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:29472 "EHLO
	asav10.insightbb.com") by vger.kernel.org with ESMTP
	id S1751167AbWIZMVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 08:21:01 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAKO2GEWBTooaLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] lockdep: lockdep_set_class_and_subclass
Date: Tue, 26 Sep 2006 08:20:57 -0400
User-Agent: KMail/1.9.3
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
       Jiri Kosina <jikos@jikos.cz>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
References: <20060926113150.294656000@chello.nl> <20060926113748.089037000@chello.nl> <20060926115404.GA18283@elte.hu>
In-Reply-To: <20060926115404.GA18283@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609260820.58837.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 September 2006 07:54, Ingo Molnar wrote:
> 
> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > Add lockdep_set_class_and_subclass() to the lockdep annotations.
> > 
> > This annotation makes it possible to assign a subclass on lock init. 
> > This annotation is meant to reduce the _nested() annotations by 
> > assigning a default subclass.
> > 
> > One could do without this annotation and rely on lockdep_set_class() 
> > exclusively, but that would require a manual stack of struct 
> > lock_class_key objects.
> > 
> > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> thanks, this extension to lockdep.c looks good to me - provided it 
> solves the problem :-)
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>
> 

I will try testing it tonight - I have a Synaptics with a pass-through
port. Anyway, it really looks good now as far as serio code concerned.

-- 
Dmitry
