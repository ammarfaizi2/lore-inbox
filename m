Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbSIXJqK>; Tue, 24 Sep 2002 05:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261630AbSIXJqK>; Tue, 24 Sep 2002 05:46:10 -0400
Received: from holomorphy.com ([66.224.33.161]:52121 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261627AbSIXJqJ>;
	Tue, 24 Sep 2002 05:46:09 -0400
Date: Tue, 24 Sep 2002 02:51:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Andries Brouwer <aebr@win.tue.nl>
Subject: Re: [patch] pgrp-fix-2.5.38-A2
Message-ID: <20020924095116.GI6070@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Andries Brouwer <aebr@win.tue.nl>
References: <Pine.LNX.4.44.0209241059480.12690-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209241059480.12690-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 11:06:51AM +0200, Ingo Molnar wrote:
> the attached patch, against BK-curr, fixes the emacs bug reported by
> Andries. It should probably also fix other, terminal handling related
> the bug was in the session_of_pgrp() function, if no proper session is
> found in the process group then we must take the session ID from the
> process that has pgrp PID (which does not necesserily have to be part of
> the pgrp). The fallback code is only triggered when no process in the
> process group has a valid session - besides being faster, this also
> matches the old implementation.
> [ hey, who needs a POSIX conformance testsuite when we have emacs! ;) ]
> 	Ingo

Fix verified here. aeb's testcase now succeeds.


Cheers,
Bill
