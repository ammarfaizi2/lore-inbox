Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288976AbSAUAKi>; Sun, 20 Jan 2002 19:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288977AbSAUAK2>; Sun, 20 Jan 2002 19:10:28 -0500
Received: from ftoomsh.progsoc.uts.edu.au ([138.25.6.1]:11786 "EHLO ftoomsh")
	by vger.kernel.org with ESMTP id <S288976AbSAUAKT>;
	Sun, 20 Jan 2002 19:10:19 -0500
Date: Mon, 21 Jan 2002 11:10:05 +1100
From: Matt <matt@progsoc.uts.edu.au>
To: Hans Reiser <reiser@namesys.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Shawn <spstarr@sh0n.net>,
        linux-kernel@vger.kernel.org, Josh MacDonald <jmacd@CS.Berkeley.EDU>
Subject: Re: Possible Idea with filesystem buffering.
Message-ID: <20020121111005.F12258@ftoomsh.progsoc.uts.edu.au>
In-Reply-To: <Pine.LNX.4.33L.0201201936340.32617-100000@imladris.surriel.com> <3C4B3B67.60505@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C4B3B67.60505@namesys.com>; from reiser@namesys.com on Mon, Jan 21, 2002 at 12:49:27AM +0300
X-OperatingSystem: Linux ftoomsh.progsoc.uts.edu.au 2.2.15-pre13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 12:49:27AM +0300, Hans Reiser wrote:
> Rik van Riel wrote:

[snip snip]

>> On basically any machine we'll have multiple memory zones.

>> Each of those memory zones has its own free list and each of the
>> zones can get low on free pages independantly of the other zones.

>> This means that if the VM asks to get a particular page freed, at
>> the very minimum you need to make a page from the same zone
>> freeable.

>> regards,

>> Rik


> I'll discuss with Josh tomorrow how we might implement support for that. 
>   A clean and simple mechanism does not come to my mind immediately.

> Hans

i know this sounds semi-evil, but can't you just drop another non
dirty page and do a copy if you need the page you have been asked to
write out? because if you have no non dirty pages around you'd
probably have to drop the page anyway at some stage..

	matt

