Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264071AbTE0SQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264016AbTE0SPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:15:36 -0400
Received: from palrel13.hp.com ([156.153.255.238]:36016 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264060AbTE0SOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:14:45 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16083.44589.855335.531141@napali.hpl.hp.com>
Date: Tue, 27 May 2003 11:27:57 -0700
To: george anzinger <george@mvista.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Richard C Bilson <rcbilson@plg2.math.uwaterloo.ca>,
       linux-kernel@vger.kernel.org, Eric Piel <Eric.Piel@Bull.Net>
Subject: Re:  setitimer 1 usec fails
In-Reply-To: <3ED28E95.6000701@mvista.com>
References: <20030526142555.67a79694.akpm@digeo.com>
	<3ED28E95.6000701@mvista.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 26 May 2003 15:00:53 -0700, george anzinger <george@mvista.com> said:

  George> As a test, you might try your test with HZ=1000 (a number I
  George> recommend for ia64, if at all possible).

I suspect you might have a slightly biased view on this. ;-) Yes,
HZ=1000 makes some problems easier to convert ticks to real time, but
slower to convert real time to ticks.

Besides, the Linux kernel MUST work with (fairly) arbitrary HZ values,
because some platforms just don't have much of a choice (e.g., Alpha
is pretty much forced to 1024Hz).

But, yes, on ia64 we can choose HZ to our liking.  If someone presents
evidence that shows a real benefit for a value other than 1024, I'm
certainly willing to listen.

	--david
