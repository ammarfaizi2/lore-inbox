Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVAXVro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVAXVro (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVAXVq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:46:26 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:4265 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261672AbVAXVpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:45:39 -0500
Message-ID: <41F56C9F.5070205@kolivas.org>
Date: Tue, 25 Jan 2005 08:46:07 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>	<87pszvlvma.fsf@sulphur.joq.us> <41F42BD2.4000709@kolivas.org>	<877jm3ljo9.fsf@sulphur.joq.us> <41F44AC2.1080609@kolivas.org>	<87hdl7v3ik.fsf@sulphur.joq.us> <87651nv356.fsf@sulphur.joq.us> <87ekgbqr2a.fsf@sulphur.joq.us>
In-Reply-To: <87ekgbqr2a.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
> I still wonder if some coding error might occasionally be letting a
> lower priority process continue running after an interrupt when it
> ought to be preempted.

Well not surprisingly I did find a bug in my patch which did not honour 
priority support between ISO threads. So basically the patch only does 
as much as the original ISO patch. I'll slap something together for more 
testing with this fixed, and ISO_FIFO support too.

Cheers,
Con
