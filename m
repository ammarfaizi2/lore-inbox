Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274803AbRJJFYW>; Wed, 10 Oct 2001 01:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274813AbRJJFYE>; Wed, 10 Oct 2001 01:24:04 -0400
Received: from [208.129.208.52] ([208.129.208.52]:17682 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274803AbRJJFXs>;
	Wed, 10 Oct 2001 01:23:48 -0400
Date: Tue, 9 Oct 2001 22:29:36 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: BALBIR SINGH <balbir.singh@wipro.com>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <3BC3D9ED.6050901@wipro.com>
Message-ID: <Pine.LNX.4.40.0110092227140.3396-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001, BALBIR SINGH wrote:

> What about cases like the pci device list or any other such list. Sometimes
> you do not care if somebody added something, while you were looking through
> the list as long as you do not get illegal addresses or data.
> Wouldn't this be very useful there? Most of these lists come up
> at system startup and change rearly, but we look through them often.
>
> Me too, Did I miss something?

What means that changes rarely that you're going to use rarely_lock() ?
If you're going to remove even only 1 element in 1000000 jiffies then
you've to lock.
If your list can only grow, that's different.




- Davide


