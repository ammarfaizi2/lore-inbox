Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267482AbTBXVRk>; Mon, 24 Feb 2003 16:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbTBXVRk>; Mon, 24 Feb 2003 16:17:40 -0500
Received: from havoc.daloft.com ([64.213.145.173]:24546 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267482AbTBXVRj>;
	Mon, 24 Feb 2003 16:17:39 -0500
Date: Mon, 24 Feb 2003 16:27:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
Message-ID: <20030224212747.GA21675@gtf.org>
References: <Pine.LNX.3.95.1030224143236.14614A-100000@chaos> <Pine.LNX.4.44.0302241259320.13406-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302241259320.13406-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 01:02:39PM -0800, Linus Torvalds wrote:
> Does gcc still warn about things like
> 
> 	#define COUNT (sizeof(array)/sizeof(element))
> 
> 	int i;
> 	for (i = 0; i < COUNT; i++)
> 		...
> 
> where COUNT is obviously unsigned (because sizeof is size_t and thus 
> unsigned)?
> 
> Gcc used to complain about things like that, which is a FUCKING DISASTER. 
> 
> Any compiler that complains about the above should be shot in the head, 
> and the warning should be killed.

Maybe...  I suppose it's an implementation issue, because the lack of
signedness issues is probably only noticeable after data value analysis.

Playing devil's advocate here, I actually don't mind it warning for a
scenarion like this, because quite often it indicates an area where, if
s/int/unsigned int/ is performed, the compiler could potentially do a
better job of optimizing.

I agree your above specific example shouldn't trigger a warning
[implementation excuses aside].

	Jeff



