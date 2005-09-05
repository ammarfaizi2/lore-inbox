Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVIEJVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVIEJVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 05:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVIEJVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 05:21:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4296 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932337AbVIEJVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 05:21:41 -0400
Date: Mon, 5 Sep 2005 02:19:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Teigland <teigland@redhat.com>
Cc: Joel.Becker@oracle.com, ak@suse.de, linux-cluster@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-Id: <20050905021948.6241f1e0.akpm@osdl.org>
In-Reply-To: <20050905092433.GE17607@redhat.com>
References: <20050901104620.GA22482@redhat.com>
	<20050903183241.1acca6c9.akpm@osdl.org>
	<20050904030640.GL8684@ca-server1.us.oracle.com>
	<200509040022.37102.phillips@istop.com>
	<20050903214653.1b8a8cb7.akpm@osdl.org>
	<20050904045821.GT8684@ca-server1.us.oracle.com>
	<20050903224140.0442fac4.akpm@osdl.org>
	<20050905043033.GB11337@redhat.com>
	<20050905015408.21455e56.akpm@osdl.org>
	<20050905092433.GE17607@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland <teigland@redhat.com> wrote:
>
> On Mon, Sep 05, 2005 at 01:54:08AM -0700, Andrew Morton wrote:
> > David Teigland <teigland@redhat.com> wrote:
> > >
> > >  We export our full dlm API through read/write/poll on a misc device.
> > >
> > 
> > inotify did that for a while, but we ended up going with a straight syscall
> > interface.
> > 
> > How fat is the dlm interface?   ie: how many syscalls would it take?
> 
> Four functions:
>   create_lockspace()
>   release_lockspace()
>   lock()
>   unlock()

Neat.  I'd be inclined to make them syscalls then.  I don't suppose anyone
is likely to object if we reserve those slots.
