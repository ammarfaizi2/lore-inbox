Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUDATpP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 14:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbUDATpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 14:45:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53979 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263095AbUDATpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 14:45:10 -0500
Date: Thu, 1 Apr 2004 14:44:50 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <kenneth.w.chen@intel.com>
Subject: Re: disable-cap-mlock
In-Reply-To: <20040401135920.GF18585@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0404011443250.5589-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004, Andrea Arcangeli wrote:

> This is a lot simpler than the mlock rlimit and this is people really
> need (not the rlimit). The rlimit thing can still be applied on top of
> this. This should be more efficient too (besides its simplicity).

What use is this patch ?

One of the main reasons for the mlock rlimit is so that
security conscious people can let normal users' gpg
mlock a few pages.

This patch isn't usable for that at all, since switching
the sysctl on would just open up the system to an easy
deadlock by any user.  Definately not something any
security conscious admin would want to enable ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

