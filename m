Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbSKDWwD>; Mon, 4 Nov 2002 17:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSKDWwD>; Mon, 4 Nov 2002 17:52:03 -0500
Received: from bitmover.com ([192.132.92.2]:4012 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262835AbSKDWwC>;
	Mon, 4 Nov 2002 17:52:02 -0500
Date: Mon, 4 Nov 2002 14:58:31 -0800
From: Larry McVoy <lm@bitmover.com>
To: Geoff Gustafson <geoff@linux.co.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Open POSIX Test Suite
Message-ID: <20021104145831.C18053@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Geoff Gustafson <geoff@linux.co.intel.com>,
	linux-kernel@vger.kernel.org
References: <000a01c28454$56a94b90$7fd40a0a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000a01c28454$56a94b90$7fd40a0a@amr.corp.intel.com>; from geoff@linux.co.intel.com on Mon, Nov 04, 2002 at 02:48:47PM -0800
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 02:48:47PM -0800, Geoff Gustafson wrote:
> I would like to announce a new project to develop and/or assemble a GPL test
> suite for POSIX APIs. 

Great idea.  We can help in the following way: BitKeeper has an extremely
simple test harness used for regressions.  It's well thought out in that
it is trivial to write simple tests and run them in isolation or to 
run the whole suite.  If you want the harness, we'll give it to you 
under whatever license you want, I assume GPL, but we don't care.

You can see what the tests look like in BK, if you have it installed, we
ship all the tests, they are in `bk bin`/t

A simple test might be

	#!/bin/sh

	# test that touch creates a file
	touch foo
	test -f foo || {
		echo failed to create foo
		exit 1
	}

The harness takes care of putting you in a clean isolated environment.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
