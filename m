Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267994AbTBWAcs>; Sat, 22 Feb 2003 19:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267997AbTBWAcs>; Sat, 22 Feb 2003 19:32:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21560 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267994AbTBWAcs>; Sat, 22 Feb 2003 19:32:48 -0500
To: Hanna Linder <hannal@us.ibm.com>
Cc: lse-tech@lists.sf.et, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
References: <96700000.1045871294@w-hlinder>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Feb 2003 17:42:53 -0700
In-Reply-To: <96700000.1045871294@w-hlinder>
Message-ID: <m1smufn7xu.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder <hannal@us.ibm.com> writes:

> 	LSE Con Call Minutes from Feb21
> 
> Minutes compiled by Hanna Linder hannal@us.ibm.com, please post
> corrections to lse-tech@lists.sf.net.
> 
> Object Based Reverse Mapping:
> (Dave McCracken, Ben LaHaise, Rik van Riel, Martin Bligh, Gerrit Huizenga)
> 

> 	Ben said none of the users have been complaining about 
> performance with the existing rmap.  Martin disagreed and said Linus, 
> Andrew Morton and himself have all agreed there is a problem.
> One of the problems Martin is already hitting on high cpu machines with 
> large memory is the space consumption by all the pte-chains filling up
> memory and killing the machine. There is also a performance impact of 
> maintaining the chains.

Note: rmap chains can be restricted to an arbitrary length, or an
arbitrary total count trivially. All you have to do is allow a fixed
limit on the number of people who can map a page simultaneously.

The selection of which chain to unmap can be a bit tricky but is
relatively straight forward.  Why doesn't someone who is seeing
this just hack this up?


Eric
