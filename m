Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269645AbRHIA0L>; Wed, 8 Aug 2001 20:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269646AbRHIA0B>; Wed, 8 Aug 2001 20:26:01 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:21000 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S269645AbRHIAZx>;
	Wed, 8 Aug 2001 20:25:53 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: encrypted swap(beating a dead horse)
Date: 9 Aug 2001 00:22:51 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9ksl4r$5us$2@abraham.cs.berkeley.edu>
In-Reply-To: <5.1.0.14.2.20010808111228.00a83720@pop.prism.gatech.edu>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 997316571 6108 128.32.45.153 (9 Aug 2001 00:22:51 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 9 Aug 2001 00:22:51 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Maynor  wrote:
>This is true, so the best thing for this, in my opinion, instead of 
>throwing the crypto blanket over everything, scrub the swap when a process 
>is terminated so when the machine is shut down, you won't have to clean the 
>entire swap.

(If I'm repeating myself and you already knew this, I apologize.)

Scrubbing swap is a good idea, but it turns out it is much harder
to do right then you might think.  In particular, data can survive
many erases, due to the physical properties of hard drives as well
as the properties of filesystems and hard drive caching.

It seems that the only way to have any assurance that you've reliably
deleted data is to ensure that it was only written in encrypted form
in the first place, and to securely erase the key when you're done
with the data and want to erase it.
