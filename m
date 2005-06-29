Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVF2R5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVF2R5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVF2R4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:56:55 -0400
Received: from mail00hq.adic.com ([63.81.117.10]:2132 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S262351AbVF2R4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:56:22 -0400
Message-ID: <42C2E0BC.8040508@xfs.org>
Date: Wed, 29 Jun 2005 12:56:12 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Al Boldi <a1426z@gawab.com>, "'Nathan Scott'" <nathans@sgi.com>,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: XFS corruption during power-blackout
References: <20050629001847.GB850@frodo> <200506290453.HAA14576@raad.intranet> <556815.441dd7d1ebc32b4a80e049e0ddca5d18e872c6e8a722b2aefa7525e9504533049d801014.ANY@taniwha.stupidest.org>
In-Reply-To: <556815.441dd7d1ebc32b4a80e049e0ddca5d18e872c6e8a722b2aefa7525e9504533049d801014.ANY@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jun 2005 17:56:13.0812 (UTC) FILETIME=[D7118340:01C57CD3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Wed, Jun 29, 2005 at 07:53:09AM +0300, Al Boldi wrote:
> 
> 
>>What I found were 4 things in the dest dir:
>>1. Missing Dirs,Files. That's OK.
>>2. Files of size 0. That's acceptable.
>>3. Corrupted Files. That's unacceptable.
>>4. Corrupted Files with original fingerprint. That's ABSOLUTELY
>>unacceptable.
> 
> 
> disk usually default to caching these days and can lose data as a
> result, disable that
> 

There are IDE drives where the vendor will tell you that you will
drasticly shorten the life of a drive if you turn off caching.
There are also cool bits of technology which use the rotational
energy of the spinning down drive to dump the cache out to a
special track (or this may be an urban legend, not sure). Problem
is, no one but the vendors really knows what any particular
disk is going to do when you pull the plug.

I did spend a bunch of time once ensuring that when you typed
sync on xfs you could pull the power right after that and
everything from before the sync survived. There have been a
lot of changes both in xfs and the surrounding kernel since
then. I do not know if anyone has attempted this effort
again recently.

If you care sufficiently about your data to want to do power fail
testing then, even assuming the filesystem works perfectly:

a) have a working, tested, regular backup policy
b) keep the backups in a different building
c) buy a UPS.

Steve
