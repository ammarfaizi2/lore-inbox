Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268800AbUJEF11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268800AbUJEF11 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 01:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268802AbUJEF11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 01:27:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5559 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268800AbUJEF1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 01:27:25 -0400
Date: Mon, 4 Oct 2004 22:27:18 -0700
Message-Id: <200410050527.i955RIwt004128@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com,
       clameter@sgi.com
Subject: Re: [PATCH] CPU time clock support in clock_* syscalls
In-Reply-To: Andrew Morton's message of  Monday, 4 October 2004 22:20:59 -0700 <20041004222059.5e9ca9f6.akpm@osdl.org>
X-Shopping-List: (1) Chimerical fruit melons
   (2) Napoleonic Lunar fiction communions
   (3) Poetic detergent retentives
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This will always return an error.

Yes, indeed.  It's just picky about which one.  Something I meant to
mention: I do not allow clock_settime on CPU timers, because I don't know
of any worthwhile reason to want to support it.  You get EINVAL or EFAULT
if your arguments are bogus, and EPERM if they are valid.  This is the
POSIX-compliant error code choice.


Thanks,
Roland
