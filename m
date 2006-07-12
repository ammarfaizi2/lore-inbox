Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWGLQP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWGLQP4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWGLQP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:15:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:63158 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751451AbWGLQPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:15:55 -0400
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: davem@davemloft.net, arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add memcpy_cachebypass, a copy routine that tries to keep cache pressure down
References: <da0cd816c4cb37c4376b.1152651055@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 12 Jul 2006 18:15:45 +0200
In-Reply-To: <da0cd816c4cb37c4376b.1152651055@localhost.localdomain>
Message-ID: <p73odvun6j2.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bryan O'Sullivan <bos@serpentine.com> writes:
> + * memcpy_cachebypass - memcpy-compatible copy routine, using streaming loads
> + * @dest: destination address
> + * @src: source address (will not be cached)
> + * @count: number of bytes to copy
> + *
> + * Use streaming loads and normal stores for a special-case copy where
> + * we know we won't be reading the source again, but will be reading the
> + * destination again soon.
> + */

For what CPU did you optimize that function?   Comment missing for that.
Also the comment should state that you're caching the target.
Also I trust you ran it through a comprehensive memcpy-all-cases tester?

-Andi
