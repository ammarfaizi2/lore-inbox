Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290837AbSBLTlc>; Tue, 12 Feb 2002 14:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290968AbSBLTlW>; Tue, 12 Feb 2002 14:41:22 -0500
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:14674
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S290837AbSBLTlJ>; Tue, 12 Feb 2002 14:41:09 -0500
Message-ID: <3C696FC5.E2DD43D7@splentec.com>
Date: Tue, 12 Feb 2002 14:40:53 -0500
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: reschedule twice from wake_up()?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.43.0.72] using ID <tluben@rogers.com> at Tue, 12 Feb 2002 14:41:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scenario:

atomic_t start, end;
current is the only task in wq;
consumer does: wait_even_interruptible(wq, start != end)
producer does: end++; wakeup_interruptible(wq)

Is it possible that the task in wq will be scheduled twice,
once since end >= start (mod something) and again since,
wakeup_interruptible was called?

-- 
Luben
