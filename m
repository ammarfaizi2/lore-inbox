Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbVL2LGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbVL2LGt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 06:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVL2LGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 06:06:49 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:35246 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S932591AbVL2LGt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 06:06:49 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] updates XFS mutex patch
References: <yq0zmmktbhk.fsf@jaguar.mkp.net>
	<1135854222.2935.15.camel@laptopd505.fenrus.org>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 29 Dec 2005 06:06:47 -0500
In-Reply-To: <1135854222.2935.15.camel@laptopd505.fenrus.org>
Message-ID: <yq0vex8tb5k.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Arjan" == Arjan van de Ven <arjan@infradead.org> writes:

Arjan> On Thu, 2005-12-29 at 05:59 -0500, Jes Sorensen wrote:
>> + +#define xfs_mutex_init(lock, type, name) mutex_init(lock)
>> +#define xfs_mutex_lock(lock, type) mutex_lock(lock) +#define
>> mutex_destroy(lock) do{}while(0)

Arjan> why not just change all mutex_init users to only pass lock?
Arjan> (same for the others) eg why add another abstraction instead of
Arjan> fixing the caller?

I have no objections to this, however I am not sure if the XFS guys
try to maintain some level of source compatibility. Just trying to
play nicely, but I agree that would be cleaner.

Cheers,
Jes
