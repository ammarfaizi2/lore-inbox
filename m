Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWBRFu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWBRFu5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 00:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWBRFu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 00:50:57 -0500
Received: from digitalimplant.org ([64.62.235.95]:58523 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1750867AbWBRFu4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 00:50:56 -0500
Date: Fri, 17 Feb 2006 21:50:46 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Andrew Morton <akpm@osdl.org>
cc: greg@kroah.com, "" <torvalds@osdl.org>, "" <linux-kernel@vger.kernel.org>,
       "" <linux-pm@osdl.org>
Subject: Re: [PATCH 1/5] [pm] Fix locking of device suspend/resume functions
In-Reply-To: <20060217205939.573e1d0c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.50.0602172145350.6792-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171756520.30811-100000@monsoon.he.net>
 <20060217205939.573e1d0c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Feb 2006, Andrew Morton wrote:

> Patrick Mochel <mochel@digitalimplant.org> wrote:
> >
> > This patch removes the unneeded down()/up() calls from
> >  suspend_device() and resume_device(). Those functions
> >  are already called under the dpm_sem, making this code
> >  unconditionally deadlock in SMP kernels.
>
> I've seen no reports of such deadlocks.  And I was testing swsusp on a
> 4-way this week?

Yup, I misparsed the code. Please disregard this patch.

Thanks,


	Pat
