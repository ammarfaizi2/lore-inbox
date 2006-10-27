Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946453AbWJ0MNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946453AbWJ0MNe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 08:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946454AbWJ0MNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 08:13:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4521 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946453AbWJ0MNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 08:13:33 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4541F2A3.8050004@sw.ru> 
References: <4541F2A3.8050004@sw.ru>  <4541BDE2.6050703@sw.ru> <45409DD5.7050306@sw.ru> <453F6D90.4060106@sw.ru> <453F58FB.4050407@sw.ru> <20792.1161784264@redhat.com> <21393.1161786209@redhat.com> <19898.1161869129@redhat.com> <22562.1161945769@redhat.com> 
To: Vasily Averin <vvs@sw.ru>
Cc: Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Q] missing unused dentry in prune_dcache()? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 27 Oct 2006 13:11:21 +0100
Message-ID: <24249.1161951081@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin <vvs@sw.ru> wrote:

> > Vasily Averin <vvs@sw.ru> wrote:
> >> Therefore I believe that my patch is optimal solution.
> > I'm not sure that prune_dcache() is particularly optimal.
> 
> I means that my patch is optimal for problem in subject.

I didn't say it wasn't.

> I would like to ask you to approve it and we will go to next issue.

I did ack it didn't I?  I must fix my mail client so that it doesn't
automatically remove my email address from the To/Cc fields when I'm replying
to a message:-/

> We have seen that umount (and remount) can work very slowly, it was cycled
> inside shrink_dcache_sb() up to several hours with taken s_umount semaphore.

umount at least should be fixed as that should no longer use
shrink_dcache_sb().

> We are trying to resolve this issue by using per-sb lru list. I'm preparing
> the patch for 2.6.19-rc3 right now and going to send it soon.

That sounds tricky; you have to check all your LRU lists to find the LRU
dentry.

David
