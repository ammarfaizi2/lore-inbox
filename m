Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWBOUCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWBOUCa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 15:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWBOUCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 15:02:30 -0500
Received: from mail.suse.de ([195.135.220.2]:43711 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751187AbWBOUC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 15:02:29 -0500
From: Andi Kleen <ak@suse.de>
To: "Christopher Friesen" <cfriesen@nortel.com>
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
Date: Wed, 15 Feb 2006 21:02:11 +0100
User-Agent: KMail/1.8.2
Cc: Ulrich Drepper <drepper@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060215151711.GA31569@elte.hu> <200602151942.20494.ak@suse.de> <43F385C1.9020508@nortel.com>
In-Reply-To: <43F385C1.9020508@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602152102.12795.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 February 2006 20:49, Christopher Friesen wrote:

> The goal is for the kernel to unlock the mutex, but the next task to 
> aquire it gets some special notification that the status is unknown.  At 
> that point the task can either validate/clean up the data and reset the 
> mutex to clean (if it can) or it can give up the mutex and pass it on to 
> some other task that does know how to validate/clean up.

The "send signal when any mapper dies" proposal would do that. The other process
could catch the signal and do something with it.

-Andi
