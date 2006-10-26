Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422910AbWJZLtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422910AbWJZLtc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 07:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbWJZLtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 07:49:32 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:37281 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161115AbWJZLtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 07:49:31 -0400
Message-ID: <4540A0C5.60700@sw.ru>
Date: Thu, 26 Oct 2006 15:49:25 +0400
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Q] missing unused dentry in prune_dcache()?
References: <453F58FB.4050407@sw.ru>
In-Reply-To: <453F58FB.4050407@sw.ru>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

I've noticed one more minor issue in your patch: in
shrink_dcache_for_umount_subtree() function you decrement dentry_stat.nr_dentry
without dcache_lock.

Thank you,
	Vasily Averin

