Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310204AbSCGLuj>; Thu, 7 Mar 2002 06:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310285AbSCGLuX>; Thu, 7 Mar 2002 06:50:23 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:21516 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S310204AbSCGLtz>;
	Thu, 7 Mar 2002 06:49:55 -0500
Date: Thu, 7 Mar 2002 20:24:11 +1100
From: Anton Blanchard <anton@samba.org>
To: Erich Focht <efocht@ess.nec.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scheduler: migration tasks startup
Message-ID: <20020307092411.GB853@krispykreme>
In-Reply-To: <Pine.LNX.4.21.0203061123270.2743-100000@sx6.ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0203061123270.2743-100000@sx6.ess.nec.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> we encountered problems with the initial distribution of the
> migration_tasks across the CPUs. Machines with 16 and more CPUs
> sometimes won't boot. 

We found this on a 31 way and have sent a fix to Ingo already, we needed
to do a set_current_state(TASK_UNINTERRUPTIBLE) before schedule_timeout()
or we just busy loop.

Anton
