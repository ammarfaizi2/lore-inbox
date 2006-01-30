Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWA3IXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWA3IXf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 03:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWA3IXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 03:23:35 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:56292 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750753AbWA3IXe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 03:23:34 -0500
Message-ID: <43DDCE36.9020902@aitel.hist.no>
Date: Mon, 30 Jan 2006 09:28:38 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davids@webmaster.com
CC: hyc@symas.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <MDEHLPKNGKAHNMBLJOLKGENPJKAB.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGENPJKAB.davids@webmaster.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:

>	Third, there's the ambiguity of the standard. It says the "sceduling
>policy" shall decide, not that the scheduler shall decide. If the policy is
>to make a conditional or delayed decision, that is still perfectly valid
>policy. "Whichever thread requests it first" is a valid scheduler policy.
>  
>
Sure.  And with a "whichever thread aquires it first" policy, then
it is obvious what happens when a mutex is released when someone
is blocked on it:  Whoever blocked on it first is then the one
who requested it first - that cannot change as the request was made
before the mutex even was released.  So then, the releasing thread has
no chance of getting the mutex back until the others have had a
go at it - no matter what threads actually gets scheduled.

Helge Hafting

