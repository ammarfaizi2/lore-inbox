Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVIENnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVIENnA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 09:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVIENnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 09:43:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37288 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932251AbVIENm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 09:42:59 -0400
Date: Mon, 5 Sep 2005 09:42:46 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/2] fix for -mm add-sem_is_read-write_locked.patch 
In-Reply-To: <26510.1125913723@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.63.0509050936240.4369@cuia.boston.redhat.com>
References: <Pine.LNX.4.63.0509031134240.567@cuia.boston.redhat.com> 
 <26510.1125913723@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2005, David Howells wrote:

> The comment attached to the drop-in replacement patch is wrong:

Indeed it is.  Good thing Andrew doesn't seem to have dropped
it in ;)

> | +static inline int sem_is_read_locked(struct rw_semaphore *sem)
> | +{
> | +	return (sem->count != 0);
> | +}
> | +
> 
> This uses the function wrong name. And:

Argh.  That should be rwsem_is_locked of course...

> Is inconsistent, though the tests are valid.

I fixed that one in a separate patch.

-- 
All Rights Reversed
