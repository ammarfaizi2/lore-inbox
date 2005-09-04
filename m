Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVIDEsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVIDEsu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 00:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVIDEsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 00:48:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19095 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751099AbVIDEss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 00:48:48 -0400
Date: Sat, 3 Sep 2005 21:46:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Phillips <phillips@istop.com>
Cc: Joel.Becker@oracle.com, linux-cluster@redhat.com, wim.coekaerts@oracle.com,
       linux-fsdevel@vger.kernel.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-Id: <20050903214653.1b8a8cb7.akpm@osdl.org>
In-Reply-To: <200509040022.37102.phillips@istop.com>
References: <20050901104620.GA22482@redhat.com>
	<20050903183241.1acca6c9.akpm@osdl.org>
	<20050904030640.GL8684@ca-server1.us.oracle.com>
	<200509040022.37102.phillips@istop.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@istop.com> wrote:
>
> The model you came up with for dlmfs is beyond cute, it's downright clever.  

Actually I think it's rather sick.  Taking O_NONBLOCK and making it a
lock-manager trylock because they're kinda-sorta-similar-sounding?  Spare
me.  O_NONBLOCK means "open this file in nonblocking mode", not "attempt to
acquire a clustered filesystem lock".  Not even close.

It would be much better to do something which explicitly and directly
expresses what you're trying to do rather than this strange "lets do this
because the names sound the same" thing.

What happens when we want to add some new primitive which has no posix-file
analog?

Waaaay too cute.  Oh well, whatever.
