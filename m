Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTELLkz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 07:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbTELLkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 07:40:55 -0400
Received: from siaag2af.compuserve.com ([149.174.40.136]:36551 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S261322AbTELLky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 07:40:54 -0400
Date: Mon, 12 May 2003 07:28:12 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Problem: strace -ff fails on 2.4.21-rc1
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305120730_MC3-1-3873-17BE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Sun, May 11, 2003 at 09:03:12PM -0400, Chuck Ebbert wrote:
>> It's hung up somewhere inside schedule().
>
>Wait 30 seconds and see if it exits by itself.  I bet you have hardware
>RTS/CTS handshaking enabled on the serial port, but without anything
>connected.

  It hangs forever (over an hour anyway.)  And it's definitely taking the
MAX_TIMEOUT case (wait forever) in schedule_timeout().

  Yes, RTS/CTS is enabled but nothing is connected... and just attaching
a nullmodem adapter that lights up CTS, DTR and CD makes the problem go
away.

  Does that mean this is a minicom problem because it didn't specify
a timeout?


