Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUG3Auc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUG3Auc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 20:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267553AbUG3Auc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 20:50:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53172 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267548AbUG3Au0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 20:50:26 -0400
Date: Thu, 29 Jul 2004 20:50:16 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp030.home.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] mlock-as-nonroot revisted
In-Reply-To: <20040729214053.GJ15895@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0407292047550.9228@dhcp030.home.surriel.com>
References: <20040729100307.GA23571@devserv.devel.redhat.com>
 <20040729142829.2a75c9b9.akpm@osdl.org> <20040729214053.GJ15895@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004, Andrea Arcangeli wrote:

> So as described some month ago such patch is insecure and conceptually
> flawed since they're using rlimits to control persistent objects that
> have absolutely nothing to do with the task itself, which in turns make
> the rlimit useless.

Which is why shared memory segments are accounted against
the USER, instead of against the TASK.

Your criticism from a few months ago was noted and the
patch got fixed.  If you want to criticise the new code,
please read it first, especially the changes to shmem.c ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
