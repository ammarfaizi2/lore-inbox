Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVBARqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVBARqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 12:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVBARqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 12:46:51 -0500
Received: from palrel13.hp.com ([156.153.255.238]:42462 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262078AbVBARqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 12:46:47 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16895.49283.929460.224645@napali.hpl.hp.com>
Date: Tue, 1 Feb 2005 09:46:43 -0800
To: baswaraj kasture <kbaswaraj@yahoo.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.21 hangs up
In-Reply-To: <20050201082001.43454.qmail@web51102.mail.yahoo.com>
References: <41FF0281.6090903@yahoo.com.au>
	<20050201082001.43454.qmail@web51102.mail.yahoo.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I trimmed the cc-list...]

>>>>> On Tue, 1 Feb 2005 00:20:01 -0800 (PST), baswaraj kasture <kbaswaraj@yahoo.com> said:

  Baswaraj> Hi, I compiled kernel 2.4.21 with intel compiler .

That's curious.  Last time I checked, the changes needed to use the
Intel-compiler have not been backported to 2.4.  What kernel sources
are you working off of?

Also, even with 2.6 you need a script from Intel which does some
"magic" GCC->ICC option translations to build the kernel with the
Intel compiler.  AFAIK, this script has not been released by Intel
(hint, hint...).

  Baswaraj> While booting it hangs-up . further i found that it
  Baswaraj> hangsup due to call to "calibrate_delay" routine in
  Baswaraj> "init/main.c". Also found that loop in the
  Baswaraj> callibrate_delay" routine goes infinite.

I suspect your kernel was just miscompiled.  We have used the
Intel-compiler internally on a 2.6 kernel and it worked fine at the
time, though I haven't tried recently.

	--david
