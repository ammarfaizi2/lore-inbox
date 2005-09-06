Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbVIFVZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVIFVZY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbVIFVZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:25:24 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:37612 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750803AbVIFVZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:25:24 -0400
Date: Tue, 6 Sep 2005 14:25:14 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: akpm@osdl.org
Cc: dwmw2@infradead.org, bunk@stusta.de, johnstul@us.ibm.com,
       drepper@redhat.com, Franz.Fischer@goyellow.de,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][Bug 5132] fix sys_poll() large timeout handling
Message-ID: <20050906212514.GB3038@us.ibm.com>
References: <20050831200109.GB3017@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831200109.GB3017@us.ibm.com>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.2005 [13:01:09 -0700], Nishanth Aravamudan wrote:
> Sorry everybody, forgot the most important Cc: :)
> 
> -Nish
> 
> Hi Andrew,
> 
> In looking at Bug 5132 and sys_poll(), I think there is a flaw in the
> current code.
> 
> The @timeout parameter to sys_poll() is in milliseconds but we compare
> it to (MAX_SCHEDULE_TIMEOUT / HZ), which is jiffies/jiffies-per-sec or
> seconds. That seems blatantly broken. Also, I think we are better served
> by converting to jiffies first then comparing, as opposed to converting
> our maximum to milliseconds (or seconds, incorrectly) and comparing.
> 
> Comments, suggestions for improvement?

I haven't got any responses (here or on the bug)... A silent NACK?
Anything I should change to make people happier?

Thanks,
Nish
