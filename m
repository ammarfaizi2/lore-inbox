Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSJQT6G>; Thu, 17 Oct 2002 15:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbSJQT6G>; Thu, 17 Oct 2002 15:58:06 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:31495 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261854AbSJQT6F>; Thu, 17 Oct 2002 15:58:05 -0400
Date: Thu, 17 Oct 2002 21:04:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017210402.A7741@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <20021017195015.A4747@infradead.org> <20021017185352.GA32537@kroah.com> <20021017195838.A5325@infradead.org> <20021017190723.GB32537@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021017190723.GB32537@kroah.com>; from greg@kroah.com on Thu, Oct 17, 2002 at 12:07:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 12:07:23PM -0700, Greg KH wrote:
> But this will require every security module project to petition for a
> syscall, which would be a pain, and is the whole point of having this
> sys_security call.

And the whole point of the reemoval is to not make adding syscalls
easy.  Adding a syscall needs review and most often you actually want
a saner interface.

> How would they be done differently now?  Multiple different syscalls?

Yes.

> 
> I do know that Dave Miller has also complained about the sys_security
> call in the past, and the difficulties along the same lines as the
> ioctl 32bit problem.  If we were to go to individual syscalls for every
> security function, this would go away.

Yes, doing the 32bit translation for a call where you don't actually
know what the arguments mean is impossible.  See the 32bit ioctl
compatiblity mess.

