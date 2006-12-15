Return-Path: <linux-kernel-owner+w=401wt.eu-S932281AbWLOAxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWLOAxs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWLOAxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:53:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55315 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932281AbWLOAxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:53:47 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Eric Dumazet" <dada1@cosmosbay.com>, "Greg KH" <gregkh@suse.de>,
       "Arjan" <arjan@linux.intel.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: kref refcnt and false positives
References: <EB12A50964762B4D8111D55B764A8454010572C1@scsmsx413.amr.corp.intel.com>
	<m13b7ivwlw.fsf@ebiederm.dsl.xmission.com>
	<20061214163519.9e5f4f64.akpm@osdl.org>
Date: Thu, 14 Dec 2006 17:53:14 -0700
In-Reply-To: <20061214163519.9e5f4f64.akpm@osdl.org> (Andrew Morton's message
	of "Thu, 14 Dec 2006 16:35:19 -0800")
Message-ID: <m1y7paughx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Guys, we have about 1000000000000000000000000000000 reports of weirdo
> crashes, smashes, bashes and splats in the kref code.  The last thing we
> need is some obscure, tricksy little optimisation which leads legitimate
> uses of the API to mysteriously fail.  
>
> If we are allocating and freeing kref-counted objects at a sufficiently
> high frequency for this thing to make a difference then we should fix that
> instead of trying to suck faster.

Agreed. Correct code maintenance certainly trumps performance.

For the same reason someone reusing the data structure shouldn't
assume the kref code left it in any particular state.

So both sides should be liberal in what they accept.

Eric
