Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbUJZFr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUJZFr4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 01:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUJZFpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 01:45:17 -0400
Received: from siaag1ag.compuserve.com ([149.174.40.13]:23762 "EHLO
	siaag1ag.compuserve.com") by vger.kernel.org with ESMTP
	id S261941AbUJZFnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 01:43:15 -0400
Date: Tue, 26 Oct 2004 01:40:16 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: My thoughts on the "new development model"
To: Bill Davidsen <davidsen@tmr.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200410260142_MC3-1-8D2A-45C2@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> I don't see the need for a development kernel, and it is desirable to be 
> able to run kernel.org kernels.

  Problem is, kernel.org 'release' kernels are quite buggy.  For example 2.6.9
has a long list of bugs:

  - superio parports don't work
  - TCP networking using TSO gives memory allocation failures
  - s390 has a serious security bug (sacf)
  - ppp hangup is broken with some peers
  - exec leaks POSIX timer memory and loses signals
  - auditing can deadlock
  - O_DIRECT and mmap IO can't be used together
  - procfs shows the wrong parent PID in some cases
  - i8042 fails to initialize with some boards using legacy USB
  - kswapd still goes into a frenzy now and then

  Sure, the next release will (may?) fix these bugs, but it will definitely
add a whole set of new ones.


--Chuck Ebbert  26-Oct-04  01:36:21
