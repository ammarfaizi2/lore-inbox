Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVGUPsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVGUPsG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 11:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVGUPqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 11:46:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54765 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261803AbVGUPo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 11:44:57 -0400
Date: Thu, 21 Jul 2005 17:44:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH] Workqueue freezer support.
Message-ID: <20050721154451.GD21475@atrey.karlin.mff.cuni.cz>
References: <1121923059.2936.224.camel@localhost> <20050721153824.GB1896@elf.ucw.cz> <20050721154234.GA1055@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050721154234.GA1055@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +struct task_struct *kthread_create(int (*threadfn)(void *data),
> > > +				   void *data,
> > > +				   const char namefmt[], ...)
> > > +{
> > > +	char result[TASK_COMM_LEN];
> > > +
> > > +	va_list args;
> > > +	va_start(args, namefmt);
> > > +	vsnprintf(result, TASK_COMM_LEN, namefmt, args);
> > > +	va_end(args);
> > > +	return _kthread_create(threadfn, data, 0, result);
> > > +}
> > > +
> > 
> > This is slightly ugly and uses lot of stack. Otherwise patch looks 
> > okay. If you want me to apply it, be sure to put me into To: or at 
> > least Cc:. Or perhaps you want to just mail it to akpm, noting that I 
> > acked it (if you do something with the char result[] :-).
> 
> TASK_COMM_LEN is only 16 bytes so it's not that bad.

Okay then ;-).
							Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
