Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289467AbSA2ObC>; Tue, 29 Jan 2002 09:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289385AbSA2Oa5>; Tue, 29 Jan 2002 09:30:57 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:34229 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S289467AbSA2OaY>;
	Tue, 29 Jan 2002 09:30:24 -0500
Date: Tue, 29 Jan 2002 09:30:24 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: DervishD <raul@viadomus.com>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: Why 'linux/fs.h' cannot be included? I *can*...
Message-ID: <20020129093024.E10404@havoc.gtf.org>
In-Reply-To: <E16VVMw-0001oa-00@DervishD.viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16VVMw-0001oa-00@DervishD.viadomus.com>; from raul@viadomus.com on Tue, Jan 29, 2002 at 11:20:02AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 11:20:02AM +0100, DervishD wrote:
>     Hello Eric :)
> 
> >>     This header can be included or not? It works for me, with headers
> >> from 2.4.17, so, is it just for backwards compatibility?
> >Policy.  It is for forwards compatibility. The general policy on kernel
> >headers is that if it breaks you get to keep the pieces.
> 
>     That is: I can include it if I just want the definition of a few
> ioctl's, but if in a future version all that is changed or even
> dissapears is completely my problem.
> 
>     Given the number of user-space apps that needs ioctl definitions
> and things like those (that are supposed not to change easily), those
> definitions should go in user-includable headers... IMHO.
> 
>     Fortunately, we have some of them in libc headers now.

The policy is, never ever include kernel headers from userspace.

Your libc should provide a "sanitized" version of the kernel headers,
which is completely separate from any kernel sources.

dietlibc does this...  it's completely independent of kernel header changes.

RedHat will be doing this with glibc in the future.

So, any problems should be reported to your libc maintainer :)

	Jeff



