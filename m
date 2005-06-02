Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVFBPLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVFBPLe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 11:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVFBPLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 11:11:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47098 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261151AbVFBPLd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 11:11:33 -0400
Date: Thu, 2 Jun 2005 08:11:14 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Esben Nielsen <simlo@phys.au.dk>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com, rostedt@goodmis.org,
       inaky.perez-gonzalez@intel.com
Subject: Re: [PATCH] Abstracted Priority Inheritance for RT
In-Reply-To: <Pine.OSF.4.05.10506021015200.28619-100000@da410.phys.au.dk>
Message-ID: <Pine.LNX.4.10.10506020806280.21686-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Jun 2005, Esben Nielsen wrote:
> 
> Let us say you have task1 waiting on task2 waiting on task3 waiting on
> task4 etc. When you try to boost the prorities you will set the priority
> of each task using the hook, right? In the hook you will set the priority
> of the next task using the hook, right? ....

No .. The callback doesn't change priorities, it just signals that a
priority has changed. The priority changing is iterative, and there is a
function added to sched.c (not in my patch, but in the RT patch) to
actualy change the priorities. My patch only adds a new structure to the
prioritiy inheritance that was already in the RT patch, I'm not remaking
the actualy PI code. 

Daniel

