Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTDKQsG (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 12:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbTDKQsG (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 12:48:06 -0400
Received: from siaag2af.compuserve.com ([149.174.40.136]:16577 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S261276AbTDKQsE (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 12:48:04 -0400
Date: Fri, 11 Apr 2003 12:57:28 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: RE: kernel support for non-English user messages
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304111259_MC3-1-3405-E080@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:


> You are right about needing to log parameters, but given a log line
> of the form
>
> %s: went up in flames\n\0eth0\0\0
>
> that can be handled by the log viewer


  I still see some problems...

  For one, there are 131 instances of:

      printk("%s\n", blurb);

in various forms in 2.5.66.  Besides possible ritual immolation of
those responsible for such things, something would have to be done
about them.

  Another problem is the one of getting that text onto the console
in readable form. The only thing I can think of is have a two-stage
process where printk puts the data into the log buffer as
zero-terminated strings and then the console write routines format
it for display.  They'd probably need their own buffers to do that.


> %s: went up in flames\n\0eth0\0\0


  Is that "\n" an actual ASCII newline or the printk escape sequence?



--
 "Let's fight until six, and then have dinner," said Tweedledum.
 --Lewis Carroll, _Through the Looking Glass_
