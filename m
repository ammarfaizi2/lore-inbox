Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbTFRKdq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 06:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbTFRKdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 06:33:46 -0400
Received: from dns1.seagha.com ([217.66.0.18]:45872 "EHLO relay-1.seagha.com")
	by vger.kernel.org with ESMTP id S265135AbTFRKdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 06:33:44 -0400
Message-ID: <6DED3619289CD311BCEB00508B8E133601177495@nt-server2.antwerp.seagha.com>
From: Karl Vogel <karl.vogel@seagha.com>
To: "'Anders Karlsson'" <anders@trudheim.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: RE: How do I make this thing stop laging?  Reboot?  Sounds like  
	Windows!
Date: Wed, 18 Jun 2003 12:49:42 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I find that the Linux VM tend to push things out in to swap-space when
> it does not need it. This is fine. However, I was once told something
> about AIX that has lodged itself in the back of my mind.
> 
> AIX uses (or used to use) the exact same way of reading/writing data
> from/to disk for all I/O. AIX also makes a distinction 
> between code and
> data. If code in RAM is unused, it simply gets flushed. If it 
> is needed
> again at a later time, it is paged in from disk where it was 
> originally
> loaded from. Only dirty data is paged out into swap.
> 
> Is it feasible to tweak the Linux VM to behave in the same fashion? If
> Linux already does it this way, I'll just shut up. :)

EUhm now a bit more constructive than my last reply (sorry, couldn't help
myself :)


Referring to Mel Gorman's excellent v2.4 kernel VM documentation:

Understanding The
Linux Virtual Memory Manager

"
12. Swap Management

Just as Linux uses free memory for purposes such as buffering data from
disk, there eventually is a need to free up private or anonymous pages used
by a process. These pages, unlike those backed by a file on disk, cannot be
simply discarded to be read in later. Instead they have to be carefully
copied to backing storage, sometimes called the swap area. This chapter
details how Linux uses and manages its backing storage.
"

http://www.csn.ul.ie/~mel/projects/vm/guide/html/understand/node73.html
