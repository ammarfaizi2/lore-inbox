Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWFGA3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWFGA3Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWFGA3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:29:24 -0400
Received: from gw.goop.org ([64.81.55.164]:12416 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751402AbWFGA3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:29:24 -0400
Message-ID: <44861DE0.6010106@goop.org>
Date: Tue, 06 Jun 2006 17:29:20 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nigel Cunningham <ncunningham@linuxmail.org>, dzickus@redhat.com,
       ak@suse.de, shaohua.li@intel.com, miles.lane@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
References: <4480C102.3060400@goop.org>	<200606070938.34927.ncunningham@linuxmail.org>	<44861899.1040506@goop.org>	<200606071013.53490.ncunningham@linuxmail.org> <20060606172410.b901950e.akpm@osdl.org>
In-Reply-To: <20060606172410.b901950e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> It all depends on what we mean by "per-cpu state".  If we were to remember
> that "CPU 7 needs 0x1234 in register 44" then that would be wrong.  But
> remembering some high-level functional thing like "CPU 7 needs to run the
> NMI watchdog" is fine.  The CPU bringup code can work out whether that is
> possible, and how to do it.
>
>   

But all the performance counter stuff is very model-specific. I don't 
think there's any abstraction which would allow us to say "CPU 7 is 
measuring branch misprediction stalls in pipeline 2" in any way other 
than "needs 0x1234 in register 44".

    J
