Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVCVSJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVCVSJN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVCVSGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:06:36 -0500
Received: from spectre.fbab.net ([212.214.165.139]:30902 "HELO mail2.fbab.net")
	by vger.kernel.org with SMTP id S261572AbVCVSFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 13:05:20 -0500
Message-ID: <42405E5C.1070501@fbab.net>
Date: Tue, 22 Mar 2005 19:05:16 +0100
From: "Magnus Naeslund(t)" <mag@fbab.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu>
In-Reply-To: <20050322112856.GA25129@elte.hu>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> bah, it's leaking dentries at a massive scale. I'm giving up on this
> variant for the time being and have gone towards a much simpler variant,
> implemented in the -40-07 patch at:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 

I downloaded your V0.7.41-08 patch and it seems to have solved my 
problem, atleast at a first glance.
The routing cache is now shrinkable with:
echo "0" > /proc/sys/net/ipv4/route/flush
That didn't work before.
I'll leave the server for a while and see if it overflows again...

Regards,
Magnus
