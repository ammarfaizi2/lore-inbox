Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWHGFWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWHGFWF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWHGFWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:22:04 -0400
Received: from gw.goop.org ([64.81.55.164]:23438 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751068AbWHGFWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:22:03 -0400
Message-ID: <44D6CE02.4020303@goop.org>
Date: Sun, 06 Aug 2006 22:22:10 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Chris Wright <chrisw@sous-sol.org>,
       virtualization <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native
 ops
References: <1154925835.21647.29.camel@localhost.localdomain>
In-Reply-To: <1154925835.21647.29.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> (Andrew, please sit these in the -mm tree for cooking)
>
> Create a paravirt.h header for (almost) all the critical operations
> which need to be replaced with hypervisor calls.
>
> For the moment, this simply includes no_paravirt.h, where all the
> native implementations now live.
>   

Sorry, but I have to say these are not yet ready for -mm.  While they're 
better than before (I can successfully boot), the machine locks up when 
I start X, and I wouldn't have any confidence in running with this stuff 
enabled.  I'd prefer these weren't in -mm until we somewhat confident 
one could run with CONFIG_PARAVIRT on all the time (ie, think it could 
be default on, even if it isn't).

    J
