Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265088AbSJRMqr>; Fri, 18 Oct 2002 08:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbSJRMqr>; Fri, 18 Oct 2002 08:46:47 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:62475 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265088AbSJRMqq>; Fri, 18 Oct 2002 08:46:46 -0400
Date: Fri, 18 Oct 2002 13:52:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Crispin Cowan <crispin@wirex.com>
Cc: "David S. Miller" <davem@redhat.com>, hch@infradead.org, greg@kroah.com,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021018135243.B1670@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Crispin Cowan <crispin@wirex.com>,
	"David S. Miller" <davem@redhat.com>, greg@kroah.com,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20021017201030.GA384@kroah.com> <20021017211223.A8095@infradead.org> <3DAFB260.5000206@wirex.com> <20021018.000738.05626464.davem@redhat.com> <3DAFC6E7.9000302@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAFC6E7.9000302@wirex.com>; from crispin@wirex.com on Fri, Oct 18, 2002 at 01:31:35AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 01:31:35AM -0700, Crispin Cowan wrote:
> That's interesting. Passing a completely opaque value (actually an 
> integer) through the system call was exactly what we designed it to do, 
> because we saw a design need for pecisely that: so that applications 
> with awareness of a specific module can talk to the module.
> 
> Could you elaborate on why this is a sign of trouble, design wise?

Because we already have such a syscall (ioctl) and we see the trouble it
causes all over the place.  Design yur interfaces properly instead.

> >If we do things such as the fs stacking or fs filter ideas,
> >that eliminates a whole swath of the facilities the security_ops
> >"provide".  No ugly syscalls passing opaque types through the kernel
> >to some magic module, but rather a real facility that is useful
> >to many things other than LSM.
> >
> Yes, that will be wonderful. And the LSM team will be pleased to re-work 
> the desing when stackable file systems appear and we can take advantage 
> of them.

So do it know.  It's possible and it just shows you've sent the LSM crap
without actually thinking about a better design.  Come back when you
have a proper design.

and btw, as LSM is part of the kernel anyone can and will change it.
Your LSM team attitude is a bit like that hated CVS mentality..
