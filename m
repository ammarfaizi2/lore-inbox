Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbULAKX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbULAKX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 05:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbULAKX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 05:23:27 -0500
Received: from viking.sophos.com ([194.203.134.132]:30478 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S261369AbULAKVX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 05:21:23 -0500
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 01/12/2004 10:21:13,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 01/12/2004 10:21:13,
	Serialize complete at 01/12/2004 10:21:13,
	S/MIME Sign failed at 01/12/2004 10:21:13: The cryptographic key was not
 found,
	S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 01/12/2004 10:21:17,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 01/12/2004 10:21:17,
	Serialize complete at 01/12/2004 10:21:17,
	S/MIME Sign failed at 01/12/2004 10:21:17: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 01/12/2004 10:21:21,
	Serialize complete at 01/12/2004 10:21:21
To: tglx@linutronix.de
Cc: akpm@osdl.org, andrea@suse.de, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH] oom killer (Core)
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF970C41E1.A8419C00-ON80256F5D.003844AA-80256F5D.0038E160@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Wed, 1 Dec 2004 10:21:17 +0000
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2004 09:49:03 linux-kernel-owner wrote:

>The oom killer has currently some strange effects when triggered.
>It gets invoked multiple times and the selection of the task to kill
>does not take processes into account which fork a lot of child processes.
>
>The patch solves this by
>- Preventing reentrancy
>- Checking for memory threshold before selection and kill.
>- Taking child processes into account when selecting the process to kill

Ah, again. :) Rusty Lynch and me tried something similar at leat twice but 
with no avail. 

We had a modular OOM killers infrastructure with two new killers. One 
would just panic on OOM situation, and other did account for parents which 
repeatedly spawned 'bad' children. Some people called it 'a bit right 
winged'. :)

Take a look at http://linux.ursulin.net if you are interested. I did not 
sync it with the latest kernel since nobody was interested. It worked for 
me. 

