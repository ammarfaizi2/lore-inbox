Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbSLOVd5>; Sun, 15 Dec 2002 16:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262828AbSLOVd4>; Sun, 15 Dec 2002 16:33:56 -0500
Received: from services.cam.org ([198.73.180.252]:19636 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S262824AbSLOVd4>;
	Sun, 15 Dec 2002 16:33:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] kexec for 2.5.51....
Date: Sun, 15 Dec 2002 16:41:49 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <200212141215.49449.tomlins@cam.org> <200212141859.07191.tomlins@cam.org> <m11y4jatbe.fsf@frodo.biederman.org>
In-Reply-To: <m11y4jatbe.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212151641.49062.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 15, 2002 04:03 pm, Eric W. Biederman wrote:
> Ed Tomlinson <tomlins@cam.org> writes:
> > Why not include this info in kexec -h ?  Bet it would prevent a few
> > failure reports...
>
> I will look, at that.
>  
> > Two more possible additions to the kexec command.  
> >
> > 1. kexec -q which returns rc=1 and types the pending selection and
> >    its command/append string if one exists and returns rc=0 if nothing
> >    is pending.  
>
> This would require effort to little purpose.  If you just call kexec
> it loads the kernel and then calls shutdown -r now.  So the loaded kernel
> should be a transient entity anyway.

Consider, you are not sure what kexec has been setup to do (maybe 
some other admin has something setup to take a crash dump etc).  You 
do not want to destroy this setup, so you do kexec -q  

Think being able to query the pending kexec is very usefull.  Also
using an rc means that scripts can use it too.

> > 2. kexec -c which clears any pending kernels.
>
> This I can and should do.  The kernel side is already implemented.

Thanks  

Ed Tomlinson
