Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVHWEzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVHWEzZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 00:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVHWEzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 00:55:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52702 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751265AbVHWEzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 00:55:25 -0400
Date: Mon, 22 Aug 2005 21:53:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cache regresions with 2.6.1x ?
Message-Id: <20050822215356.5f6a30fd.akpm@osdl.org>
In-Reply-To: <5a2cf1f60508220421d0914f8@mail.gmail.com>
References: <5a2cf1f60508220421d0914f8@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste <jerome.lacoste@gmail.com> wrote:
>
> I am on a Dell Inspiron 8100 laptop with 512 M and 1G disk cache. I
>  usually have at least 4 big applications running simultaneously: a
>  Java IDE, firefox, firefox and X. All that under the Gnome desktop.
> 
>  I've sometimes seen periods where my laptop goes kind of nuts. While
>  the cpu is still at 0%, the workload goes to 100% (as shown in the
>  gnome process monitor) (I haven't checked in other means, e.g. top or
>  /proc info as my machine is unusable).
> 
>  But with my latest upgrade to 2.6.12 from 2.6.10, the hanging happens
>  much more often. It lasts for over 30 seconds.
> 
>  Could this hanging be related to swapping?
>  Are there any VM regression lately that would make a kernel less
>  appropriate for desktop use?
>  How can I investigate that further?

10-20 lines of `vmstat 1' output while it's happening would help.

If lots of system time is being consumed then the next step is to generate
a kernel profile - Documentation/basic_profiling.txt
