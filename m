Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSJQSwn>; Thu, 17 Oct 2002 14:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262159AbSJQSwn>; Thu, 17 Oct 2002 14:52:43 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:10247 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261973AbSJQSwm>; Thu, 17 Oct 2002 14:52:42 -0400
Date: Thu, 17 Oct 2002 19:58:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017195838.A5325@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20021017195015.A4747@infradead.org> <20021017185352.GA32537@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021017185352.GA32537@kroah.com>; from greg@kroah.com on Thu, Oct 17, 2002 at 11:53:52AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 11:53:52AM -0700, Greg KH wrote:
> No, don't remove this!

> Yes, it's a big switch, but what do you propose otherwise?  SELinux
> would need a _lot_ of different security calls, which would be fine, but
> we don't want to force every security module to try to go through the
> process of getting their own syscalls.

They should register their syscalls with the kernel properly. Look
at what e.g. the streams people did after the sys_call_table
removal.  It's enough that IRIX suffers from the syssgi syndrome, no
need to copy redo their mistakes in Linux.

> And other subsystems in the kernel do the same thing with their syscall,
> like networking, so there is a past history of this usage.

But they don't allow any random module to implement it.  And anyone
asked today says the horrible sys_Scoketcall and sys_ipc cludges
were a mistake.

> Linus, please do not apply.

Well, getting it applyed was the intent of sending out this mail..

