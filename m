Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992639AbWJTQj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992639AbWJTQj2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992630AbWJTQj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:39:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26772 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992660AbWJTQj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:39:27 -0400
Date: Fri, 20 Oct 2006 09:39:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Albert Cahalan <acahalan@gmail.com>,
       Cal Peake <cp@absolutedigital.net>
Subject: Re: [CFT] Grep to find users of sys_sysctl.
Message-Id: <20061020093915.58961ba3.akpm@osdl.org>
In-Reply-To: <m1bqo7406k.fsf@ebiederm.dsl.xmission.com>
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
	<Pine.LNX.4.64.0610181129090.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net>
	<20061018124415.e45ece22.akpm@osdl.org>
	<m17iyw7w92.fsf_-_@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0610191218020.32647@lancer.cnet.absolutedigital.net>
	<m1wt6v4gcx.fsf_-_@ebiederm.dsl.xmission.com>
	<20061020003540.10d367d9.akpm@osdl.org>
	<m1bqo7406k.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 06:54:43 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> > On Fri, 20 Oct 2006 01:05:18 -0600
> > ebiederm@xmission.com (Eric W. Biederman) wrote:
> >
> >> 
> >> Anyone who is interested in knowing if they have an application on
> >> their system that actually uses sys_sysctl please run the following grep.
> >> 
> >> find / -type f  -perm /111 -exec fgrep 'sysctl@@GLIBC' '{}' ';' 
> >> 
> >> The -perm /111 is an optimization to only look at executable files,
> >> and may be omitted if you are patient.
> >> 
> >> Currently I don't expect anyone to find a match anywhere except in
> > libpthreads,
> >> if you find any others please let me know.
> >> 
> >
> > http://www.google.com/codesearch
> >
> > there are a few hits...
> 
> What were you using for search criteria?
> 
> A challenge is to weed out code that runs on BSDs where people do use sysctl.

I just used "sysctl" and clicked a lot.

>From a quick scan:

http://www.google.com/codesearch?q=+sysctl+linux+-glibc+show:ezM3VpAIwOY:VqU4ELp0K4A:GC7QFUptQys&sa=N&cd=51&ct=rc&cs_p=http://www.xorp.org/releases/0.2/xorp-0.2.tar.gz&cs_f=xorp-0.2/ospfd/linux/system.C#a0

http://www.google.com/codesearch?q=+sysctl+-glibc+show:dPzMrf8geLs:EbNoGzoYDAc:I-_8YloL1fY&sa=N&cd=11&ct=rc&cs_p=http://www.openwall.com/scanlogd/lib/libnet-1.1.3-RC-01.tar.gz&cs_f=libnet/src/libnet_link_bpf.c#a0

http://www.google.com/codesearch?q=+sysctl+-glibc+show:QQ2BcrelppE:zZeMmMrGko0:BFmHNHvdqyA&sa=N&cd=17&ct=rc&cs_p=http://www.cpan.org/authors/id/B/BR/BRYCE/Test-Parser-1.4.tar.gz&cs_f=Test-Parser-1.4/lib/Test/Parser/Sysctl.pm#a0

http://www.google.com/codesearch?q=+sysctl+-glibc+show:yqt7gBTAktI:350f8_WXUz8:J6r1Ge4gTiw&sa=N&cd=23&ct=rc&cs_p=http://darwinsource.opendarwin.org/tarballs/apsl/top-9.tar.gz&cs_f=top-9/libtop.c#a0

http://www.google.com/codesearch?q=+sysctl+-glibc+show:-9-E1kR2zW0:HD_LhbY9gNM:Wt7DONTBSR4&sa=N&cd=65&ct=rc&cs_p=http://sparemint.atariforge.net/sparemint/mint/kernel/1.15.12/freemint-1.15.12-src.tar.gz&cs_f=freemint-1.15.12/tools/sysctl/sysctl.c#a0

http://www.google.com/codesearch?q=+sysctl+-glibc+show:A8hxeTvi8Lc:rlNCNnWdQuo:lUO9tYzCStY&sa=N&cd=102&ct=rc&cs_p=http://www.opensource.apple.com/darwinsource/tarballs/other/OpenLDAP-69.0.2.tar.gz&cs_f=OpenLDAP-69.0.2/OpenLDAP/libraries/liblutil/uuid.c#a0

http://www.google.com/codesearch?q=+sysctl+-glibc+show:8eVH0Ss2hrY:Yg_zU6fz4U8:akq5ZzLPf34&sa=N&cd=107&ct=rc&cs_p=ftp://ftp.stacken.kth.se/pub/arla/arla-0.42.tar.gz&cs_f=arla-0.42/lib/roken/getdtablesize.c#a0

http://www.google.com/codesearch?q=+sysctl+-glibc+show:NXzHfAnEMjg:ZIWovlf1IWU:WZdEzr-Zs0o&sa=N&cd=112&ct=rc&cs_p=http://gentoo.osuosl.org/distfiles/bind-9.3.2-P1.tar.gz&cs_f=bind-9.3.2-P1/lib/isc/unix/ifiter_sysctl.c#a0

Quite a lot of networking-related utilities.  Including bind and openldap.
