Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUE0FEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUE0FEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 01:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUE0FEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 01:04:34 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:60039 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261378AbUE0FEd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 01:04:33 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 26 May 2004 22:04:22 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Vadim Lobanov <vadim@cs.washington.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: epoll question
In-Reply-To: <20040526214852.I23529-100000@attu3.cs.washington.edu>
Message-ID: <Pine.LNX.4.58.0405262158060.11185@bigblue.dev.mdolabs.com>
References: <20040526214852.I23529-100000@attu3.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004, Vadim Lobanov wrote:

> I have a quick question about the behavior of epoll. My usage scenario is 
> as follows:
> 
> I add multiple fd's to the epoll set. Some of the fd's will have a lot of 
> data coming in, while others will have noticeably less.
> I start to epoll for events, only letting it return one event at a time
> 
> In this case, will the lesser-active fd's be starved out by the 
> constantly-active fd's, or will they still be reliably seen?

Nope, even if you extract one fd at a time (???) the itam will be removed 
from head and, if LT or ET and another event will come soon after, it will 
be tail queued.


- Davide

