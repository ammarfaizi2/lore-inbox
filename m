Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVASF3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVASF3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 00:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVASF3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 00:29:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.191]:7147 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261468AbVASF3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 00:29:15 -0500
Subject: Re: [PATCH][RFC] sched: Isochronous class for unprivileged soft rt
	scheduling
From: utz <utz@s2y4n2c.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com, joq@io.com,
       CK Kernel <ck@vds.kolivas.org>
In-Reply-To: <41ED08AB.5060308@kolivas.org>
References: <41ED08AB.5060308@kolivas.org>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 06:26:09 +0100
Message-Id: <1106112369.3956.7.camel@segv.aura.of.mankind>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a3828f1c4d839cf12e8a3b808f7ed34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con

I just played with your SCHED_ISO patch and found a simple way to crash
my machine.

I'm running this as unprivileged user with SCHED_ISO:

main ()
{
        while(1) {
                sched_yield();
        }
}

The system hangs about 3s and then reboots itself.
2.6.11-rc1 + 2.6.11-rc1-iso-0501182249 on an UP Athlon XP.

With real SCHED_FIFO it just lockup the system.
 
utz


