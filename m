Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbVBCBMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbVBCBMe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 20:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbVBCBMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 20:12:33 -0500
Received: from mail.joq.us ([67.65.12.105]:64747 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262862AbVBCBML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 20:12:11 -0500
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <200502022303.j12N3nZa002055@localhost.localdomain>
	<42016661.80908@bigpond.net.au>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 02 Feb 2005 19:13:03 -0600
In-Reply-To: <42016661.80908@bigpond.net.au> (Peter Williams's message of
 "Thu, 03 Feb 2005 10:46:41 +1100")
Message-ID: <87d5viigyo.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> writes:

>>> If you have the source code for the programs then they could be
>>> modified to drop the root euid after they've changed policy.  Or
>>> even do the

> Paul Davis wrote:
>> This is insufficient, since they need to be able to drop RT
>> scheduling and then reacquire it again later.

> I believe that there are mechanisms that allow this.  The setuid man
> page states that a process with non root real uid but setuid as root
> can use the seteuid call to use the _POSIX_SAVED_IDS mechanism to
> drop and regain root privileges as required.

Which every system cracker knows.  Any attack on such a program is
going to re-acquire root privileges and take over the system.

Temporarily dropping privileges gains no security whatsoever.  It is
nothing more than a coding convenience.  The program remains *inside*
the system security perimeter.
-- 
  joq
