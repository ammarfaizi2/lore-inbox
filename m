Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318282AbSGRRC2>; Thu, 18 Jul 2002 13:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318281AbSGRRC2>; Thu, 18 Jul 2002 13:02:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60406 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318278AbSGRRC1>; Thu, 18 Jul 2002 13:02:27 -0400
Subject: Re: [PATCH] per-cpu patch 2/3
From: Robert Love <rml@tech9.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020718042221.36D114479@lists.samba.org>
References: <20020718042221.36D114479@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Jul 2002 10:05:26 -0700
Message-Id: <1027011926.1086.118.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 20:48, Rusty Russell wrote:
> Given the ongoing races with smp_processor_id() and preempt, this
> makes sense to me.  this_cpu() was too generic a name anyway.

Very nice, although:

How do you reenable preemption?

We already have get_cpu() and put_cpu() which do pretty much what you
are suggesting (and put_cpu() enables preemption) and are used by code
today.  If you want to make changes to them, that is fine, but we should
keep the interface...

	Robert Love


