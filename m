Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVDFLWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVDFLWi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 07:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVDFLWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 07:22:35 -0400
Received: from mail.customers.edis.at ([62.99.242.131]:8373 "EHLO
	smtp-1.edis.at") by vger.kernel.org with ESMTP id S262164AbVDFLWd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 07:22:33 -0400
Message-ID: <4253C67F.3010802@lawatsch.at>
Date: Wed, 06 Apr 2005 13:22:39 +0200
From: Philip Lawatsch <philip@lawatsch.at>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Philip Lawatsch <philip@lawatsch.at>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org
Subject: Re: AMD64 Machine hardlocks when using memset
References: <3Ojst-4kX-19@gated-at.bofh.it> <3OGIo-7oY-13@gated-at.bofh.it> <3OGIo-7oY-15@gated-at.bofh.it> <3OGIo-7oY-17@gated-at.bofh.it> <3OGIo-7oY-11@gated-at.bofh.it> <3OIh7-cc-1@gated-at.bofh.it> <3OITV-AR-3@gated-at.bofh.it> <3PxjH-812-3@gated-at.bofh.it> <42535FFF.4080503@shaw.ca> <4253C0FC.6070402@lawatsch.at>
In-Reply-To: <4253C0FC.6070402@lawatsch.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Lawatsch wrote:

>>Anyone have any suggestions on how to track this further? It seems
>>fairly clear what circumstances are causing it, but as for figuring out
>>what's at fault..
> 

> It seems that mov'ing does not kill my machine while simply using movnti
> does.

Forget about what I just wrote, I've been able to reproduce this in
32bit mode too although it did take a long while to happen.

And glibc in 32bit mode simply uses mov in a normal loop to write to the
memory.

Looks like using mov in 64bit mode polluted my cache and crippled
performance (have been running some other programs in the background)
and thus perhaps didnt trigger the problem.

I'm going nuts with this.

kind regards Philip
