Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVFBPTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVFBPTR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 11:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVFBPTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 11:19:17 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:384 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S261157AbVFBPTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 11:19:12 -0400
Date: Thu, 2 Jun 2005 17:18:35 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com, rostedt@goodmis.org,
       inaky.perez-gonzalez@intel.com
Subject: Re: [PATCH] Abstracted Priority Inheritance for RT
In-Reply-To: <Pine.LNX.4.10.10506020806280.21686-100000@godzilla.mvista.com>
Message-Id: <Pine.OSF.4.05.10506021713200.3853-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2005, Daniel Walker wrote:

> 
> 
> On Thu, 2 Jun 2005, Esben Nielsen wrote:
> > 
> > Let us say you have task1 waiting on task2 waiting on task3 waiting on
> > task4 etc. When you try to boost the prorities you will set the priority
> > of each task using the hook, right? In the hook you will set the priority
> > of the next task using the hook, right? ....
> 
> No .. The callback doesn't change priorities, it just signals that a
> priority has changed. The priority changing is iterative, and there is a
> function added to sched.c (not in my patch, but in the RT patch) to
> actualy change the priorities. My patch only adds a new structure to the
> prioritiy inheritance that was already in the RT patch, I'm not remaking
> the actualy PI code. 
>
Good :-)
I asked the question because I considered (and started but didn't
have time) doing what you have done. I wanted to generalise the rt_mutex
to have real rw_lock as well - which was dropped due to the
non-deterministc behavioir even with PI. To do that I needed to have the
recursion and the callback..
 
Esben

> Daniel
> 

