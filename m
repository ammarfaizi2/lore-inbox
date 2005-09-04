Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVIDFnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVIDFnj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 01:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVIDFnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 01:43:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751170AbVIDFni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 01:43:38 -0400
Date: Sat, 3 Sep 2005 22:41:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: phillips@istop.com, linux-cluster@redhat.com, wim.coekaerts@oracle.com,
       linux-fsdevel@vger.kernel.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-Id: <20050903224140.0442fac4.akpm@osdl.org>
In-Reply-To: <20050904045821.GT8684@ca-server1.us.oracle.com>
References: <20050901104620.GA22482@redhat.com>
	<20050903183241.1acca6c9.akpm@osdl.org>
	<20050904030640.GL8684@ca-server1.us.oracle.com>
	<200509040022.37102.phillips@istop.com>
	<20050903214653.1b8a8cb7.akpm@osdl.org>
	<20050904045821.GT8684@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
>  > What happens when we want to add some new primitive which has no posix-file
>  > analog?
> 
>  	The point of dlmfs is not to express every primitive that the
>  DLM has.  dlmfs cannot express the CR, CW, and PW levels of the VMS
>  locking scheme.  Nor should it.  The point isn't to use a filesystem
>  interface for programs that need all the flexibility and power of the
>  VMS DLM.  The point is a simple system that programs needing the basic
>  operations can use.  Even shell scripts.

Are you saying that the posix-file lookalike interface provides access to
part of the functionality, but there are other APIs which are used to
access the rest of the functionality?  If so, what is that interface, and
why cannot that interface offer access to 100% of the functionality, thus
making the posix-file tricks unnecessary?
