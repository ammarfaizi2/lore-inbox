Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129958AbRCAWEr>; Thu, 1 Mar 2001 17:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129986AbRCAWEh>; Thu, 1 Mar 2001 17:04:37 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:47414 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129958AbRCAWEQ>; Thu, 1 Mar 2001 17:04:16 -0500
Message-ID: <3A9EC713.FD2B5997@sgi.com>
Date: Thu, 01 Mar 2001 14:02:59 -0800
From: Rajagopal Ananthanarayanan <ananth@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-4SGI_20smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <97mdsr$7p310$1@fido.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

	[ ... ]

> Except that your code throws the random junk at the elevator all
> the time, while my code only bothers the elevator every once in
> a while. This should make it possible for the disk reads to
> continue with less interruptions.
> 

Couldn't agree with you more. The elevator does a decent job
these days, but higher level clustering could do more ...

	[ ...]

> Indeed. IMHO we should fix this by putting explicit IO
> clustering in the ->writepage() functions.

Enhancing writepage() to perform clustering is the first step.
In addition you want entities (kupdated, kswapd, et. al)
that currently work with only buffers to invoke writepage()
at appropriate points. Just today I sent a patch that does this
and also combines delayed allocation out to Al Viro for comments.
If anyone else is interested I can send it out to the list.

ananth.

--------------------------------------------------------------------------
Rajagopal Ananthanarayanan ("ananth")
Member Technical Staff, SGI.
--------------------------------------------------------------------------
