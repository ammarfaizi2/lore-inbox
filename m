Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRC2VQW>; Thu, 29 Mar 2001 16:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRC2VQM>; Thu, 29 Mar 2001 16:16:12 -0500
Received: from chromium11.wia.com ([207.66.214.139]:24588 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S129066AbRC2VQF>; Thu, 29 Mar 2001 16:16:05 -0500
Message-ID: <3AC3A6C9.991472C0@chromium.com>
Date: Thu, 29 Mar 2001 13:19:05 -0800
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux scheduler limitations?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm working on an enhanced version of Apache and I'm hitting my head
against something I don't understand.

I've found a (to me) unexplicable system behaviour when the number of
Apache forked instances goes somewhere beyond 1050, the machine
suddently slows down almost top a halt and becomes totally unresponsive,
until I stop the test (SpecWeb).

Profiling the kernel shows that the scheduler and the interrupt handler
are taking most of the CPU time.

I understand that there must be a limit to the number of processes that
the scheduler can efficiently handle, but I would expect some sort of
gradual performance degradation when increasing the number of tasks,
instead I observe that by increasing Apache's MaxClient linit by as
little as 10 can cause a sudden transition between smooth working with
lots (30-40%) of CPU idle to a total lock-up.

Moreover the max number of processes is not even constant. If I increase
the server load gradually then I manage to have 1500 processes running
with no problem, but if the transition is sharp (the SpecWeb case) than
I end-up having a lock up.

Anybody seen this before? Any clues?

 - Fabio


