Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313986AbSDQAtv>; Tue, 16 Apr 2002 20:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313987AbSDQAtu>; Tue, 16 Apr 2002 20:49:50 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:46789 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S313986AbSDQAtt>;
	Tue, 16 Apr 2002 20:49:49 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15548.50859.169392.857907@napali.hpl.hp.com>
Date: Tue, 16 Apr 2002 17:49:47 -0700
To: Davide Libenzi <davidel@xmailserver.org>
Cc: davidm@hpl.hp.com, Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <Pine.LNX.4.44.0204161013050.1460-100000@blue1.dev.mcafeelabs.com>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 16 Apr 2002 10:18:18 -0700 (PDT), Davide Libenzi <davidel@xmailserver.org> said:

  Davide> i still have pieces of paper on my desk about tests done on
  Davide> my dual piii where by hacking HZ to 1000 the kernel build
  Davide> time went from an average of 2min:30sec to an average
  Davide> 2min:43sec. that is pretty close to 10%

The last time I measured timer tick overhead on ia64 it was well below
1% of overhead.  I don't really like using kernel builds as a
benchmark, because there are far too many variables for the results to
have any long-term or cross-platform value.  But since it's popular, I
did measure it quickly on a relatively slow (old) Itanium box: with
100Hz, the kernel compile was about 0.6% faster than with 1024Hz
(2.4.18 UP kernel).

	--david
