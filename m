Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWJ0NrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWJ0NrH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 09:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbWJ0NrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 09:47:06 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:16986 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751007AbWJ0NrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 09:47:05 -0400
Message-ID: <45420DD4.9020602@sw.ru>
Date: Fri, 27 Oct 2006 17:47:00 +0400
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
References: <4541F2A3.8050004@sw.ru>  <4541BDE2.6050703@sw.ru> <45409DD5.7050306@sw.ru> <453F6D90.4060106@sw.ru> <453F58FB.4050407@sw.ru> <20792.1161784264@redhat.com> <21393.1161786209@redhat.com> <19898.1161869129@redhat.com> <22562.1161945769@redhat.com> <24249.1161951081@redhat.com>
In-Reply-To: <24249.1161951081@redhat.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Vasily Averin <vvs@sw.ru> wrote:
>> I would like to ask you to approve it and we will go to next issue.
> 
> I did ack it didn't I?  I must fix my mail client so that it doesn't
> automatically remove my email address from the To/Cc fields when I'm replying
> to a message:-/

To prevent any mistake I've resend this patch again to you and akpm@.

>> We have seen that umount (and remount) can work very slowly, it was cycled
>> inside shrink_dcache_sb() up to several hours with taken s_umount semaphore.
> 
> umount at least should be fixed as that should no longer use
> shrink_dcache_sb().

Umount calls shrink_dcache_sb in "Special case for "unmounting" root".
Usually it happen only once, but in case OpenVZ it happens every time when any
Virtual server is stopped, each of them have own isolated root partition.

>> We are trying to resolve this issue by using per-sb lru list. I'm preparing
>> the patch for 2.6.19-rc3 right now and going to send it soon.

Please wait until my following email, it will be ready soon

thank you,
	Vasily Averin
