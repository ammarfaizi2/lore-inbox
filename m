Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWCNX2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWCNX2S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWCNX2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:28:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43469 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932163AbWCNX2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:28:17 -0500
Date: Wed, 15 Mar 2006 00:00:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: What is ptrace flag PT_TRACESYSGOOD for?
Message-ID: <20060314230056.GA1579@elf.ucw.cz>
References: <200603140531_MC3-1-BAA0-B3C3@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200603140531_MC3-1-BAA0-B3C3@compuserve.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 14-03-06 05:26:52, Chuck Ebbert wrote:
> I am trying to document PTRACE_SETOPTIONS and I can't figure out what
> the option PTRACE_O_TRACESYSGOOD is used for.  Google is no help;
> I can't find an explanation for _why_ it's there.  All I can see is that
> it causes ptrace() to deliver syscall stops with SIGTRAP | 0x80
> instead of just SIGTRAP and it can be used with PTRACE_SYSEMU.

Yes.. and unless you deliver ptrace() syscall stops with different
signal, you can't tell difference between syscall stop and real
SIGTRAP.

See subterfugue.org for example user.

Basically we'd like all the new users to set PTRACE_O_TRACESYSGOOD.

								Pavel
-- 
181:
