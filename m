Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267737AbUIDM2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267737AbUIDM2T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 08:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267745AbUIDM2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 08:28:18 -0400
Received: from relay.pair.com ([209.68.1.20]:13330 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267737AbUIDM2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 08:28:16 -0400
X-pair-Authenticated: 66.188.111.210
Message-ID: <4139B4DE.9060905@cybsft.com>
Date: Sat, 04 Sep 2004 07:28:14 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R3
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu> <4138A56B.4050006@cybsft.com> <20040903181710.GA10217@elte.hu> <20040903193052.GA16617@elte.hu> <413939F8.1030806@cybsft.com> <20040904064121.GA31348@elte.hu>
In-Reply-To: <20040904064121.GA31348@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>http://www.cybsft.com/testresults/crashes/2.6.9-rc1-vo-R3.txt
> 
> 
> the first line seems partial - isnt the full oops in the log?

Agreed. Unfortunately that is all there is.

> 
> 
>>Sorry I forgot to mention that this was triggered running the
>>stress-kernel package, minus the NFS-Compile, but it does include the
>>CRASHME test. In addition, amlat was running as well. The system was
>>pretty much 100% loaded.
> 
> 
> Have you run crashme as root? That would be unsafe.

Actually what happens is that it creates a "crashme" user (and group)
for running the test and then deletes the user after the test. In fact
the user is still in passwd, because of the crash it didn't get cleaned
up. So I don't think this SHOULD be a problem.


