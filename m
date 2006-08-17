Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWHQJ6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWHQJ6L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWHQJ6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:58:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:35171 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932273AbWHQJ6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:58:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RRVFDzbtvtlPArOv0aUpaylvbUBAukmnrSlrklfLYIQkTB1i8XFFBYomwBSiPyWxqMMpntlSHRgB0bk3ygQyoXvvECdkwFoB1nz0j/4nfXzEtCzkCMjcEWUJxCaxTJg3yziU10YQrbAMmw3OnPMaMx+hrqlVLqs4XBwFv3JZZzo=
Message-ID: <9a8748490608170258s32df0272r60c8c540e5871485@mail.gmail.com>
Date: Thu, 17 Aug 2006 11:58:07 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: [NFS] 2.6.17.8 - do_vfs_lock: VFS is out of sync with lock manager!
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net,
       "Trond Myklebust" <trond.myklebust@fys.uio.no>
In-Reply-To: <17636.4462.975774.528003@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490608080739w2e14e5ceg44a7bf0a3b475704@mail.gmail.com>
	 <17636.4462.975774.528003@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/06, Neil Brown <neilb@suse.de> wrote:
> On Tuesday August 8, jesper.juhl@gmail.com wrote:
> > I have some webservers that have recently started reporting the
> > following message in their logs :
> >
> >   do_vfs_lock: VFS is out of sync with lock manager!
>
>
> I can imagine that happening if you mount with '-o nolocks'.
> Then a non-blocking lock could cause that message (I think).
> Can you conform that you aren't using 'nolocks'.
>
Confirmed.

All my webservers (the ones that generate this message) are identical
and this is the filesystems they have and their mount options:

/ is on a local scsi disk, ext3 fs, mounted with (rw)
/boot is on a local scsi disk, ext3 fs, mounted with (rw)
users homedirs (where the DocumentRoots are) are NFS mounted with
mount options (rw,rsize=8192,wsize=8192,hard,intr,addr=xxx.xxx.xxx.xxx)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
