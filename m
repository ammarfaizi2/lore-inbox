Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbWHIIHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbWHIIHn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWHIIHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:07:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:34210 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965079AbWHIIHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:07:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fCfg+z0sHUHiOkYjUaqbnBTrUTTuR1irAvWN6MMaFd9fSM1WAkJAeDcBSQXqpiEP+DWL1I5XIBEu6qqSfoPE8rWMgwf+LYsRnMakplzJNzWFwBRazFBzzkZNVqbuiKYmxWkZN3aICLDe5e7h9r2Jk+Hkge1nUNZhZI6vrcD1H/g=
Message-ID: <9a8748490608090107j6ce7bc2cr2b74cc13b9541f39@mail.gmail.com>
Date: Wed, 9 Aug 2006 10:07:40 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Grant Coady" <gcoady.lk@gmail.com>
Subject: Re: 2.6.17.8 - do_vfs_lock: VFS is out of sync with lock manager!
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       nfs@lists.sourceforge.net
In-Reply-To: <ketid21n1s5bn108lo7ps9t8a85db5bgs9@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490608080739w2e14e5ceg44a7bf0a3b475704@mail.gmail.com>
	 <ketid21n1s5bn108lo7ps9t8a85db5bgs9@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/06, Grant Coady <gcoady.lk@gmail.com> wrote:
> On Tue, 8 Aug 2006 16:39:54 +0200, "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>
> >I have some webservers that have recently started reporting the
> >following message in their logs :
> >
> >  do_vfs_lock: VFS is out of sync with lock manager!
> >
> >The serveres kernels were upgraded to 2.6.17.8 and since the upgrade
> >the message started appearing.
> >The servers were previously running 2.6.13.4 without experiencing this problem.
> >Nothing has changed except the kernel.
> >
> >I've googled a bit and found this mail
> >(http://lkml.org/lkml/2005/8/23/254) from Trond saying that
> >"The above is a lockd error that states that the VFS is failing to track
> >your NFS locks correctly".
> >Ok, but that doesn't really help me resolve the issue. The servers are
> >indeed running NFS and access their apache DocumentRoots from a NFS
> >mount.
> >
> >Is there anything I can do to help track down this issue?
>
> I don't have an answer, but offer this observation: five boxen running
> 2.6.17.8 doing six simultaneous
>
>   bzcat /home/share/linux-2.6/patch-2.6.18-rc4.bz2|patch -p1
>
> didn't burp.  The /home/share/ is an NFS export from another box running
> 2.4.33-rc3a, me not sure if this was exercising any NFS locking as the
> NFS source file was only opened for non-exclusive read-only.
>
The NFS server here is running 2.6.11.11 and doesn't seem to be
reporting any problems. But I now have two more of my webservers (both
running 2.6.17.8) that have started to complain about "do_vfs_lock:
VFS is out of sync with lock manager!"

I've not found a way to cause the message to be repported at will unfortunately.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
