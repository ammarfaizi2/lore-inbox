Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWEXWgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWEXWgI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 18:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWEXWgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 18:36:08 -0400
Received: from outgoing.tpinternet.pl ([193.110.120.20]:45889 "EHLO
	outgoing.tpinternet.pl") by vger.kernel.org with ESMTP
	id S964786AbWEXWgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 18:36:05 -0400
In-Reply-To: <20060505191127.GA16076@thunk.org>
References: <8.420169009@selenic.com> <65CF7F44-0452-4E94-8FC1-03B024BCCAE7@mac.com> <20060505172424.GV15445@waste.org> <20060505191127.GA16076@thunk.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <79CAB553-E966-4AD8-B32F-07F33F29452F@neostrada.pl>
Cc: Matt Mackall <mpm@selenic.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Date: Thu, 25 May 2006 00:35:37 +0200
To: Theodore Tso <tytso@mit.edu>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-05-05, at 21:11, Theodore Tso wrote:

> I've always thought the right answer is that whether or not network
> packet arrival times should be used as entropy input should be
> configurable, since depending on the environment, it might or might
> not be safe, and for some hosts (particularly diskless servers), the
> network might be the only source of entropy available to them.

The trully concerned should simply use true random number generators.  
Like a zenner diodes noise.
For everybody else... most if not all of what /dev/random does, just  
simply
isn't worth the trouble at all. Thus the less of it the better.
BTW. Did somebody notice that the whole disc seek time dance around / 
dev/random does,
is quite idiotic for deterministic flash drives? It will screw yours  
"randomness" silently...

