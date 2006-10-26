Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423463AbWJZMfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423463AbWJZMfW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423465AbWJZMfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:35:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48286 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423463AbWJZMfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:35:20 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4540A0C5.60700@sw.ru> 
References: <4540A0C5.60700@sw.ru>  <453F58FB.4050407@sw.ru> 
To: Vasily Averin <vvs@sw.ru>
Cc: Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Q] missing unused dentry in prune_dcache()? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 26 Oct 2006 13:33:58 +0100
Message-ID: <10443.1161866038@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin <vvs@sw.ru> wrote:

> I've noticed one more minor issue in your patch: in
> shrink_dcache_for_umount_subtree() function you decrement
> dentry_stat.nr_dentry without dcache_lock.

Hmmm... that's a very good point:-/  I wonder if I can batch them.

David
