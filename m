Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVKMDAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVKMDAa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 22:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVKMDA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 22:00:29 -0500
Received: from ns.suse.de ([195.135.220.2]:12987 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751099AbVKMDA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 22:00:29 -0500
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Subject: Re: [PATCH 17/18] unbindable mounts
References: <E1EZInj-0001F9-CG@ZenIV.linux.org.uk>
From: Andi Kleen <ak@suse.de>
Date: 13 Nov 2005 04:00:18 +0100
In-Reply-To: <E1EZInj-0001F9-CG@ZenIV.linux.org.uk>
Message-ID: <p73d5l545h9.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> writes:

> From: Ram Pai <linuxram@us.ibm.com>
> Date: 1131402080 -0500
> 
> A unbindable mount does not forward or receive propagation. Also unbindable
> mount disallows bind mounts. The semantics is as follows.
> 
> Bind semantics:
>   Its invalid to bind mount a unbindable mount.
> Move semantics:
>   Its invalid to move a unbindable mount under shared mount.
> Clone-namespace semantics:
>   If a mount is unbindable in the parent namespace, the corresponding
>   cloned mount in the child namespace becomes unbindable too.  Note:
>   there is subtle difference, unbindable mounts cannot be bind mounted
>   but can be cloned during clone-namespace.

What is it good for?
Normally I would have expected that to be part of the description.


-Andi (slightly worried about all these different mount variants. Hopefully
you guys themselves can still keep them all in your heads)
