Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbUJZKpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbUJZKpL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 06:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUJZKpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 06:45:10 -0400
Received: from mail.aei.ca ([206.123.6.14]:63424 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262213AbUJZKpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 06:45:03 -0400
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: My thoughts on the "new development model"
Date: Tue, 26 Oct 2004 06:44:46 -0400
User-Agent: KMail/1.7
Cc: Bill Davidsen <davidsen@tmr.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200410260142_MC3-1-8D2A-45C2@compuserve.com>
In-Reply-To: <200410260142_MC3-1-8D2A-45C2@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410260644.47307.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 October 2004 01:40, Chuck Ebbert wrote:
> Bill Davidsen wrote:
> 
> > I don't see the need for a development kernel, and it is desirable to be 
> > able to run kernel.org kernels.
> 
>   Problem is, kernel.org 'release' kernels are quite buggy.  For example 2.6.9
> has a long list of bugs:
> 
>   - superio parports don't work
>   - TCP networking using TSO gives memory allocation failures
>   - s390 has a serious security bug (sacf)
>   - ppp hangup is broken with some peers
>   - exec leaks POSIX timer memory and loses signals
>   - auditing can deadlock
>   - O_DIRECT and mmap IO can't be used together
>   - procfs shows the wrong parent PID in some cases
>   - i8042 fails to initialize with some boards using legacy USB
>   - kswapd still goes into a frenzy now and then
> 
>   Sure, the next release will (may?) fix these bugs, but it will definitely
> add a whole set of new ones.

To my mind this just points out the need for a bug fix branch.   e.g. a
branch containing just bug/security fixes against the current stable
kernel.  It might also be worth keeping the branch active for the n-1
stable kernel too.

Ed

PS.  we could call this the Bug/Security or bs kernels.
