Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbUK0Aee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbUK0Aee (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUKZX4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:56:11 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9413 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263109AbUKZTov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:44:51 -0500
Date: Thu, 25 Nov 2004 09:42:33 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Michael Kerrisk <mtk-lkml@gmx.net>
cc: hugh@veritas.com, chrisw@osdl.org, manfred@colorfullife.com,
       torvalds@osdl.org, akpm@osdl.org, michael.kerrisk@gmx.net,
       linux-kernel@vger.kernel.org
Subject: Re: Further shmctl() SHM_LOCK strangeness
In-Reply-To: <13535.1101386724@www65.gmx.net>
Message-ID: <Pine.LNX.4.61.0411250941230.10497@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0411250639530.10497@chimarrao.boston.redhat.com>
 <13535.1101386724@www65.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2004, Michael Kerrisk wrote:

> I don't think this is sufficient -- there must
> be protection against arbitrary SHM_LOCKs.

Why?   We already have ulimits do that...

> How about the following:
>
> For *both* SHM_LOCK and SHM_UNLOCK, the process should either
> be the owner or the creator of the object or have the
> CAP_IPC_LOCK capability.

It makes a lot of sense, but I don't know whether or not
it'd break any applications...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
