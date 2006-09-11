Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWIKV0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWIKV0J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWIKV0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:26:09 -0400
Received: from gw.goop.org ([64.81.55.164]:34716 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S964897AbWIKV0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:26:07 -0400
Message-ID: <4505D45C.9090807@goop.org>
Date: Mon, 11 Sep 2006 14:25:48 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: [patch] i386-PDA, lockdep: fix %gs restore
References: <20060908011317.6cb0495a.akpm@osdl.org> <200609101032.17429.ak@suse.de> <20060910115722.GA15356@elte.hu> <200609101334.34867.ak@suse.de> <20060910132614.GA29423@elte.hu> <20060910093307.a011b16f.akpm@osdl.org> <450499D3.5010903@goop.org> <20060911052527.GA12301@elte.hu> <4505BA1C.8050200@goop.org>
In-Reply-To: <4505BA1C.8050200@goop.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> Ingo Molnar wrote:
>> Subject: [patch] i386-PDA, lockdep: fix %gs restore
>> From: Ingo Molnar <mingo@elte.hu>
>>
>> in the syscall exit path the %gs selector has to be restored _after_ the
>> last kernel function has been called. If lockdep is enabled then this
>> kernel function is TRACE_IRQS_ON.
>>
>> Signed-off-by: Ingo Molnar <mingo@elte.hu>
>>   
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

Actually, this patch is wrong.  I'll post a fix shortly.

    J
