Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbUCPX5C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbUCPX5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:57:02 -0500
Received: from colin2.muc.de ([193.149.48.15]:14 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261854AbUCPX5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:57:00 -0500
Date: 17 Mar 2004 00:56:58 +0100
Date: Wed, 17 Mar 2004 00:56:58 +0100
From: Andi Kleen <ak@muc.de>
To: Peter Williams <peterw@aurema.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040316235658.GA70879@colin2.muc.de>
References: <1zkOe-Uc-17@gated-at.bofh.it> <1zl7M-1eJ-43@gated-at.bofh.it> <1zn9p-3mW-5@gated-at.bofh.it> <1znj5-3wM-15@gated-at.bofh.it> <1AaWr-655-7@gated-at.bofh.it> <m3fzc9o7bc.fsf@averell.firstfloor.org> <40569655.2030802@aurema.com> <20040316061611.GA77627@colin2.muc.de> <40578A87.8030501@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40578A87.8030501@aurema.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> These programs could (and should) use sysconfig(_SC_CLK_TCK) to find out 
> how many ticks there are in a second so this does not constitute a good 
> reason for USER_HZ not being equal to HZ.

These programs are usually shell scripts that initialise some sysctls.
It's not easy to call sysconf from there. Also we tend to avoid breaking
things that would fail silently instead of failing with an obvious error 
message.  This would be such a case. Silent breakage is an extremly bad
thing.

-Andi
