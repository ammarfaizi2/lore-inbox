Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265925AbUBRAWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266887AbUBRAWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:22:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:25565 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265925AbUBRAUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:20:33 -0500
Date: Tue, 17 Feb 2004 16:20:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Robert White <rwhite@casabyte.com>
cc: tridge@samba.org, "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'Al Viro'" <viro@parcelfarce.linux.theplanet.co.uk>,
       "'Neil Brown'" <neilb@cse.unsw.edu.au>
Subject: RE: UTF-8 and case-insensitivity
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAABSIByOpdrUqd8yc+ZmEhqQEAAAAA@casabyte.com>
Message-ID: <Pine.LNX.4.58.0402171619010.2154@home.osdl.org>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAABSIByOpdrUqd8yc+ZmEhqQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, Robert White wrote:
>
> OK, so I wrote the below, but then in the summary I realized that there was
> a significant factor that doesn't fit in with the rest of the post.  Case
> insensitivity, and more generally locale equivalence rules, is a security
> nightmare.  Consider the number of different file names that "su" could map
> to if you apply case insensitivity (4) and/or worse yet the various accents
> and umlats (?,etc) that sort-equivalent for "u" in some locales.  The user
> types "su" and runs "S(u-umlat)" etc. 

This is but one reason why I will _refuse_ to make case insensitivity
magically start happening on regular "open()" etc calls.

You'd literally have to use a _different_ system call to do a 
case-insensitive file open. Exactly because anything else would be very 
confusing to existing apps (and thus be potential security holes).

		Linus
