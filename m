Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265709AbSJTASG>; Sat, 19 Oct 2002 20:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265715AbSJTASF>; Sat, 19 Oct 2002 20:18:05 -0400
Received: from ns.suse.de ([213.95.15.193]:39944 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265709AbSJTASF> convert rfc822-to-8bit;
	Sat, 19 Oct 2002 20:18:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Subject: Re: [PATCH][RFC] 2.5.42 (1/2): Filesystem capabilities kernel patch
Date: Sun, 20 Oct 2002 02:24:07 +0200
User-Agent: KMail/1.4.3
Cc: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org
References: <87y98vmuqf.fsf@goat.bogus.local>
In-Reply-To: <87y98vmuqf.fsf@goat.bogus.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210200224.07867.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 October 2002 21:07, Olaf Dietsche wrote:
> This patch adds filesystem capabilities to 2.5.42, but it applies to
> 2.5.43 as well.
>
> It's very simple. In the root directory of every filesystem, there
> must be a file named ".capabilities". This is the capability database
> indexed by inode number. These files are populated by a chcap tool,
> see next mail.
>
> This fs capability system should work on all filesystem, which can
> provide long dotted names and have some sort of inode. Another benefit
> is, when holes in files are allowed. Otherwise the .capabilities file
> could grow pretty large.
>
> I use this on an ext2 filesystem. It boots and seems to work so far.
>
> Comments?

Capabilities should be implemented as extended attributes; see Ted's recent 
postings. Adding the necessary kernel infrastructure as extended attributes 
is pretty simple. We will need to spend more time on producing good user 
space tools, and figuring out ways so that the whole thing remains 
manageable.

--Andreas.

