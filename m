Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbUAZLKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 06:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbUAZLKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 06:10:21 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:16876 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264605AbUAZLKQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 06:10:16 -0500
Message-ID: <4014F50E.6020201@cyberone.com.au>
Date: Mon, 26 Jan 2004 22:07:58 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: Andrew Morton <akpm@osdl.org>, Philippe Elie <phil.el@wanadoo.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oprofile per-cpu buffer overrun
References: <20040126023715.GA3166@zaniah> <20040125200701.3c7b769a.akpm@osdl.org> <20040126103237.GA52771@compsoc.man.ac.uk>
In-Reply-To: <20040126103237.GA52771@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Levon wrote:

>On Sun, Jan 25, 2004 at 08:07:01PM -0800, Andrew Morton wrote:
>
>
>>When implementing a circular buffer it is better to not constrain the head
>>and tail indices - just let them grow and wrap without bound.  You only need
>>to bring them in-bounds when you actually use them to index the buffer.
>>
>
>I'm not sure why that's better.
>
>
>>- head-tail is always the amount of used space, no need to futz around
>>  handling the case where one has wrapped and the other hasn't.
>>
>
>I admit I have a hangover, but it seems to me it would actually be more
>complicated to make damn sure that the integer overflow case is
>definitely handled properly.
>

You needn't worry about integer overflow - it is handled properly ;)


