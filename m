Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWB1SmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWB1SmN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWB1SmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:42:13 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:61569 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S932404AbWB1SmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:42:12 -0500
Message-ID: <44049981.6040503@namesys.com>
Date: Tue, 28 Feb 2006 10:42:09 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Marr <marr@flex.com>,
       reiserfs-dev@namesys.com
Subject: Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM Change?
References: <200602241522.48725.marr@flex.com> <20060224211650.569248d0.akpm@osdl.org> <200602261407.33262.ioe-lkml@rameria.de> <4401B233.7050308@yahoo.com.au> <44036670.7060204@namesys.com> <44039A83.4050604@yahoo.com.au>
In-Reply-To: <44039A83.4050604@yahoo.com.au>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Hans Reiser wrote:
>
>> Sounds like the real problem is that glibc is doing filesystem
>> optimizations without making them conditional on the filesystem type.
>
>
> I'm not sure that it should even be conditional on the filesystem type...
> To me it seems silly to even bother doing it, although I guess there
> is another level of buffering involved which might mean it makes more
> sense.
>
I was not saying that filesystem optimizations should be done in glibc
rather than in the kernel, I was merely forgoing judgement on that
point.   Actually, I rather doubt that they should be in glibc, but
maybe someday someone will come up with some legit example of where it
belongs in glibc.  I cannot think of one myself though.
