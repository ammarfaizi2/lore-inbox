Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSFUOOl>; Fri, 21 Jun 2002 10:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSFUOOk>; Fri, 21 Jun 2002 10:14:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35778 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316609AbSFUOOk>;
	Fri, 21 Jun 2002 10:14:40 -0400
Date: Fri, 21 Jun 2002 07:08:28 -0700 (PDT)
Message-Id: <20020621.070828.112704404.davem@redhat.com>
To: george@mvista.com
Cc: rml@tech9.net, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace timer_bh with tasklet
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D13326C.E2383356@mvista.com>
References: <3D126B28.16C88E2B@mvista.com>
	<20020620.180358.33292945.davem@redhat.com>
	<3D13326C.E2383356@mvista.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: george anzinger <george@mvista.com>
   Date: Fri, 21 Jun 2002 07:04:28 -0700

   "David S. Miller" wrote:
   > It is the whole issue.  We have to stop all timers while we run the
   > non-SMP safe protocol code.
   
   Thanks.  I think this can be done much the same way it is now.  I
   will modify the patch accordingly.
   
Thanks, now what about every piece of code doing cli() and expects
timers not to run because of that?  Are you going to audit all of that
too?

I think you still have no idea at all how much breakage you're going
to cause nor how much work is necessary to fix that.
