Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267507AbUJNWdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267507AbUJNWdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUJNWcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:32:12 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:26860 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267507AbUJNW0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:26:19 -0400
Date: Fri, 15 Oct 2004 00:26:17 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] move semaphore definitions to waitlock_types.h
In-Reply-To: <20041014220554.GA14731@infradead.org>
Message-ID: <Pine.LNX.4.61.0410150015060.877@scrub.home>
References: <Pine.LNX.4.61.0410142345020.29976@scrub.home>
 <20041014220554.GA14731@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 14 Oct 2004, Christoph Hellwig wrote:

> > This moves the definition and initializer of semaphore, rw_semaphore and
> > wait queue structures to waitlock_types.h.
> 
> The name is really horrible.

Why? Actually I find it quite logical, we have types.h and posix_types.h. 
waitlock_types.h describes rather well what it contains.

> names.  But I must say I really hate this kind of separation as it makes
> the code rather hard to follow.

The code is still where it was before. :)
It's just a bit unfamiliar that the types are in separate header, but not 
doing this means we can't use any inline functions or next time we want 
restructure anything, you are busy to get everything compiled again.
I'm open to better ideas, but I don't see a way around this.

bye, Roman
