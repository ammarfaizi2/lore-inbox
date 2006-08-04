Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161286AbWHDQ0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161286AbWHDQ0m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 12:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161287AbWHDQ0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 12:26:42 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:30907 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161286AbWHDQ0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 12:26:42 -0400
Message-ID: <44D3753B.1060403@sgi.com>
Date: Fri, 04 Aug 2006 18:26:35 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
       ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se>	<44BE9E78.3010409@garzik.org> <yq0lkq4vbs3.fsf@jaguar.mkp.net>	<1154702572.23655.226.camel@localhost.localdomain>	<44D35B25.9090004@sgi.com>	<1154706687.23655.234.camel@localhost.localdomain>	<44D36E8B.4040705@sgi.com> <je4pws1ofb.fsf@sykes.suse.de>	<44D370ED.2050605@sgi.com> <jezmekzdb5.fsf@sykes.suse.de>
In-Reply-To: <jezmekzdb5.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
> Jes Sorensen <jes@sgi.com> writes:
> 
>> We know that today long is the only one that differs and that
>> m68k has horrible natural alignment rules for historical reasons, but
>> besides that it's pretty sane.
> 
> Try determining the alignment of u64 on i386.  You will be surprised.

If thats the case, then thats really scary :-( I'd claim it's a bug and
I am willing to be that iptables isn't the only place that is affected
or will be in the future.

Would a fix along the lines of this work?

typedef long long u64 __attribute__ ((aligned (8));

Cheers,
Jes
