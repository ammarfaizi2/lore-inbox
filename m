Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWBNQNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWBNQNU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWBNQNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:13:20 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:10969 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1161109AbWBNQNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:13:19 -0500
Date: Tue, 14 Feb 2006 11:13:19 -0500
From: Christopher Faylor <christopher.faylor@timesys.com>
To: linux-kernel@vger.kernel.org, "Robb, Sam" <sam.robb@timesys.com>,
       Sam Ravnborg <sam@ravnborg.org>, zippel@linux-m68k.org, akpm@osdl.org,
       Kyle McMartin <kyle@parisc-linux.org>
Subject: Re: [PATCH] kconfig: detect if -lintl is needed when linking conf,mconf
Message-ID: <20060214161319.GA17161@trixie.casa.cgf.cx>
References: <3D848382FB72E249812901444C6BDB1D03E051E7@exchange.timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D848382FB72E249812901444C6BDB1D03E051E7@exchange.timesys.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 12:24:12PM -0500, Robb, Sam wrote:
>Kyle McMartin <kyle@parisc-linux.org> wrote:
>>On Mon, Jan 30, 2006 at 01:26:47PM -0500, Robb, Sam wrote:
>>>   This patch attempts to correct the problem by detecting whether or not
>>> NLS support requires linking with libintl.
>>
>>Sigh. Can everyone please stop assuming gcc can output to /dev/null? On 
>>several platforms, ld tries to lseek in the output file, and fails if it 
>>can't.
>
>Ouch.  Out of curiosity - what is the reason for this behavior in ld?

Ouch, indeed.

I'd be interested in details on which platforms perform so lamely.  When
I grep for lseek and its variants in the bfd and ld source code, the only
occurrences that I see are all working on object files - as I would expect.

-Chris Faylor
(one of the) binutils maintainers
