Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269200AbTGUCkr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 22:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269202AbTGUCkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 22:40:47 -0400
Received: from [216.208.38.106] ([216.208.38.106]:46574 "EHLO
	lapdancer.baythorne.internal") by vger.kernel.org with ESMTP
	id S269200AbTGUCkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 22:40:46 -0400
Subject: Re: [PATCH] Washing suspend code
From: David Woodhouse <dwmw2@infradead.org>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: ffrederick@prov-liege.be, linux-kernel@vger.kernel.org
In-Reply-To: <20030702131047.GA9779@suse.de>
References: <S263945AbTGBIGc/20030702080632Z+4079@vger.kernel.org>
	 <20030702131047.GA9779@suse.de>
Content-Type: text/plain
Message-Id: <1058727060.1091.2.camel@lapdancer.baythorne.internal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Mon, 21 Jul 2003 03:55:30 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-02 at 14:10, Dave Jones wrote:
> On Wed, Jul 02, 2003 at 10:43:11AM +0200, ffrederick@prov-liege.be wrote:
>  >  }
>  > +int touchable_process (struct task_struct *p)
>  > +{
>  > +	return(!((p->flags & PF_IOTHREAD) || (p == current) || (p->state == TASK_ZOMBIE)))
>  > +
>  > +}
> 
> *horror*. Please keep the formatting of the original macro.
> It's a) more readable, and b) Documentation/CodingStyle compliant.

Bugger the formatting. The original macro invocation 'INTERESTING(p)'
may invoke 'continue;' and change the flow of execution in an utterly
unobvious manner. The 'if (something) continue;' form is _definitely_
better.

-- 
dwmw2

