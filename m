Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWFUBpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWFUBpR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbWFUBpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:45:16 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:13450 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750743AbWFUBpO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:45:14 -0400
Date: Tue, 20 Jun 2006 20:44:53 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH] kthread: convert stop_machine into a kthread
Message-ID: <20060621014453.GA18821@sergelap.austin.ibm.com>
References: <20060615144331.GB16046@sergelap.austin.ibm.com> <20060619201450.3434f72f.akpm@osdl.org> <20060620082745.GA28092@sergelap> <20060620014027.eba58cb7.akpm@osdl.org> <20060620162706.GB21542@sergelap.austin.ibm.com> <20060620154241.024ad134.akpm@osdl.org> <20060621005206.GA24600@sergelap.austin.ibm.com> <20060620181856.df8afa60.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620181856.df8afa60.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (akpm@osdl.org):
> On Tue, 20 Jun 2006 19:52:06 -0500
> "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> 
> > here's
> > the patch I meant to send.
> > 
> > ...
> >
> > -static int stopmachine(void *cpu)
> > +static int stopmachine(void)
> > ...
> > -		tsk = kthread_run(stopmachine, (void *)(long)i, "stopmachine");
> > +		tsk = kthread_create(stopmachine, NULL, "stopmachine");
> 
> This should have spat a compiler warning.
> 
> The confidence level on all of this ain't high.  Please, test the patch
> which I merged?

Compiles, boots, and shuts down on s390.

thanks,
-serge
