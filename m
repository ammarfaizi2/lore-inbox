Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVBXAx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVBXAx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVBXAx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 19:53:56 -0500
Received: from gw.goop.org ([64.81.55.164]:54210 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S261732AbVBXAuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 19:50:21 -0500
Message-ID: <421D24BD.1090307@goop.org>
Date: Wed, 23 Feb 2005 16:50:05 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: Roland McGrath <roland@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Always send siginfo for synchronous signals
References: <421C25BE.1090700@goop.org> <20050223201903.GF21662@shell0.pdx.osdl.net> <421D0D3F.40902@goop.org> <20050223234626.GZ15867@shell0.pdx.osdl.net>
In-Reply-To: <20050223234626.GZ15867@shell0.pdx.osdl.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>>/proc/N/status will tell you that a process has
>>a signal pending, but it won't tell you how many are pending).
>>    
>>
>
>Suggestion for good place to display that info?
>  
>
I guess another line in /proc/N/status:

    SigQue: 0 0 0 0 0 0 0 123 0 0 1238 0 0 0 0 0 ... 0 0 1

or something, but I haven't really thought about it.

>>In fact, bugs with these symptoms have been reported against Valgrind
>>from time to time for years, and its only recently I worked out what's
>>going on (mostly because I introduced a bug which caused Valgrind to do
>>it to itself).
>>    
>>
>This code is pretty new (since 2.6.8-rc1, last June), so I expect some
>other issue in the years past.
>  
>
There was always a limit on the number of pending queue siginfo
signals.  It used to be system-wide rather than per-user though.

    J
