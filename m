Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314072AbSDQGRq>; Wed, 17 Apr 2002 02:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314073AbSDQGRp>; Wed, 17 Apr 2002 02:17:45 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:51930 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S314072AbSDQGRo>;
	Wed, 17 Apr 2002 02:17:44 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15549.4991.111039.680357@napali.hpl.hp.com>
Date: Tue, 16 Apr 2002 23:17:35 -0700
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, Mark Mielke <mark@mark.mielke.cc>,
        davidm@hpl.hp.com, Davide Libenzi <davidel@xmailserver.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <1019023303.1670.37.camel@phantasy>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 17 Apr 2002 02:01:42 -0400, Robert Love <rml@tech9.net> said:

  Robert> Exactly - this was my issue.  So what _was_ the rationale
  Robert> behind Alpha picking 1024 (and others following)?

Picking a timer tick is a bit like picking the color of a
window. Everybody has an opinion and there is no truly "right" choice.
I guarantee you whatever you pick, someone will come along and say:
why not X instead?

A power-of-2 value obviously makes it easy to divide by HZ.

  Robert> More importantly, can we change to 1000?

On ia64, you can make it anything you want.  User-level will pick up
the current value from sysconf(_SC_CLK_TCK).

	--david
