Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWEVDam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWEVDam (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWEVDal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:30:41 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:1517 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964988AbWEVDal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:30:41 -0400
Message-ID: <4471305F.40105@bigpond.net.au>
Date: Mon, 22 May 2006 13:30:39 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Con Kolivas <kernel@kolivas.org>, Rene Herman <rene.herman@keyaccess.nl>,
       Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc2+ regression -- audio skipping
References: <4470CC8F.9030706@keyaccess.nl>	 <200605221033.49153.kernel@kolivas.org> <1148264043.7643.15.camel@homer>	 <200605221243.54100.kernel@kolivas.org> <1148267426.21765.15.camel@homer>
In-Reply-To: <1148267426.21765.15.camel@homer>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 22 May 2006 03:30:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Mon, 2006-05-22 at 12:43 +1000, Con Kolivas wrote:
>> On Monday 22 May 2006 12:14, Mike Galbraith wrote:
>>> In my tree, I don't use the expired array for anything except batch
>>> tasks any more for this very reason. The latency just hurts too bad.
>> So it's turning your tree into a single priority array design effectively just 
>> like staircase ;) ?
> 
> Similar I suppose.  I still do have dual arrays though, because it's an
> almost free way to deal with batch tasks (and is now named accordingly).
> 
> I also still use sleep_avg, but I keep it sane, and with the full
> dynamic spread instead of gravitating to either full or empty, and I
> monitor for cpu hungry tasks, and let them climb the ladder to where the
> action is.  That way, it retains the pleasant interactivity of the
> current design, yet is absolutely starvation proof.

What about the batch tasks?  How do you ensure that they don't get 
starved?  Remember they're "batch" tasks not "background" tasks.

Do you force an array switch after a while and if so how do you handle 
the adverse effects that will have on any non batch tasks on the other 
queue?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
