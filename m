Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbTDLQjM (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 12:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbTDLQjM (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 12:39:12 -0400
Received: from siaag2ad.compuserve.com ([149.174.40.134]:32656 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S263335AbTDLQjM (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 12:39:12 -0400
Date: Sat, 12 Apr 2003 12:47:30 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: RE: kernel support for non-English user messages
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304121250_MC3-1-3426-17FF@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You are right about needing to log parameters, but given a log line
> of the form
>
> %s: went up in flames\n\0eth0\0\0
>
> that can be handled by the log viewer


  How about this scheme instead?

    printk("%s: went up in flames\n", "eth0");

would become

    \0eth0\0: went up in flames\n\0\0

i.e. the zeros would mark a transition between text that came from
parameters and what was from the format string.  This would be a
lot easier to write to the console.


--
 "Let's fight till six, and then have dinner," said Tweedledum.
  --Lewis Carroll, _Through the Looking Glass_
