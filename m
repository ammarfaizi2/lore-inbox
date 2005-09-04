Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVIDHaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVIDHaa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 03:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVIDHaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 03:30:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34223 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751181AbVIDHa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 03:30:29 -0400
Date: Sun, 4 Sep 2005 00:28:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Phillips <phillips@istop.com>
Cc: Joel.Becker@oracle.com, linux-cluster@redhat.com, wim.coekaerts@oracle.com,
       linux-fsdevel@vger.kernel.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-Id: <20050904002828.3d26f64c.akpm@osdl.org>
In-Reply-To: <200509040240.08467.phillips@istop.com>
References: <20050901104620.GA22482@redhat.com>
	<200509040022.37102.phillips@istop.com>
	<20050903214653.1b8a8cb7.akpm@osdl.org>
	<200509040240.08467.phillips@istop.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@istop.com> wrote:
>
> If the only user is their tools I would say let it go ahead and be cute, even 
>  sickeningly so.  It is not supposed to be a general dlm api, at least that is 
>  my understanding.  It is just supposed to be an interface for their tools.  
>  Of course it would help to know exactly how those tools use it.

Well I'm not saying "don't do this".   I'm saying "eww" and "why?".

If there is already a richer interface into all this code (such as a
syscall one) and it's feasible to migrate the open() tricksies to that API
in the future if it all comes unstuck then OK.  That's why I asked (thus
far unsuccessfully):

   Are you saying that the posix-file lookalike interface provides
   access to part of the functionality, but there are other APIs which are
   used to access the rest of the functionality?  If so, what is that
   interface, and why cannot that interface offer access to 100% of the
   functionality, thus making the posix-file tricks unnecessary?

