Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVLDOu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVLDOu1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 09:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVLDOu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 09:50:27 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:28100 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S932229AbVLDOu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 09:50:27 -0500
Message-ID: <011201c5f8e1$557c32a0$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: <linux-kernel@vger.kernel.org>
References: <016c01c5f6cc$0e28e6d0$0400a8c0@dcccs> <1133481721.9597.37.camel@lade.trondhjem.org> <00e501c5f809$99c70bc0$0400a8c0@dcccs> <1133622663.7911.5.camel@lade.trondhjem.org>
Subject: Re: 2.6.15-rc3: adduser: unable to lock password file
Date: Sun, 4 Dec 2005 15:45:12 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Trond Myklebust" <trond.myklebust@fys.uio.no>
To: "JaniD++" <djani22@dynamicweb.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, December 03, 2005 4:11 PM
Subject: Re: 2.6.15-rc3: adduser: unable to lock password file


> On Sat, 2005-12-03 at 14:00 +0100, JaniD++ wrote:
>
> > Here is the strace-s output:     (20KB)
> > http://download.netcenter.hu/bughunt/20051203/adduser.log
> >
> > This problem is always on on 2.6.15-rc3, and newer on 2.6.14.2
>
> OK... Looks like it is bailing out after the lines
>
> link("/etc/passwd.2522", "/etc/passwd.lock") = 0
> stat64("/etc/passwd.2522", {st_mode=S_IFREG|0600, st_size=5, ...}) = 0
>
> I'll bet the stat64 is filing to show that the file now has 2 links.
>
> As a first step, could you please grab the 2 patches
>
>
http://client.linux-nfs.org/Linux-2.6.x/2.6.15-rc4/linux-2.6.15-01-nfs-cache-init.dif
> and
>
http://client.linux-nfs.org/Linux-2.6.x/2.6.15-rc4/linux-2.6.15-02-fix_cache_consistency.dif
>
> and see if they fix the problem?

done.
No change. :(

Cheers,

Janos



>
> Cheers,
>   Trond
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

