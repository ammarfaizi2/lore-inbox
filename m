Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWFSGmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWFSGmo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 02:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWFSGmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 02:42:44 -0400
Received: from mail.gmx.net ([213.165.64.21]:57783 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751139AbWFSGmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 02:42:43 -0400
X-Authenticated: #14349625
Subject: Re: [RFC] CPU controllers?
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, sam@vilain.net, vatsa@in.ibm.com, dev@openvz.org,
       mingo@elte.hu, pwil3058@bigpond.net.au, sekharan@us.ibm.com,
       balbir@in.ibm.com, linux-kernel@vger.kernel.org,
       maeda.naoaki@jp.fujitsu.com, kurosawa@valinux.co.jp
In-Reply-To: <20060618233522.c2690983.akpm@osdl.org>
References: <20060615134632.GA22033@in.ibm.com>
	 <4493C1D1.4020801@yahoo.com.au> <20060617164812.GB4643@in.ibm.com>
	 <4494DF50.2070509@yahoo.com.au> <4494EA66.8030305@vilain.net>
	 <4494EE86.7090209@yahoo.com.au> <20060617234259.dc34a20c.akpm@osdl.org>
	 <1150616176.7985.50.camel@Homer.TheSimpsons.net>
	 <20060618020932.5947a7dc.akpm@osdl.org>
	 <1150624169.9324.12.camel@Homer.TheSimpsons.net>
	 <1150698525.4659.8.camel@Homer.TheSimpsons.net>
	 <20060618233522.c2690983.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 08:46:13 +0200
Message-Id: <1150699573.8326.2.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-18 at 23:35 -0700, Andrew Morton wrote:
> On Mon, 19 Jun 2006 08:28:45 +0200
> Mike Galbraith <efault@gmx.de> wrote:
> 
> > This is kinda OT for this thread, but here's another example of where
> > the IO can easily foil CPU distribution plans.  I wonder how many folks
> > get nailed by /proc being mounted without noatime,nodiratime like I just
> > apparently did.
> > 
> > top           D E29B4928     0 10174   8510                     (NOTLB)
> >        d2f63c4c 00100100 00200200 e29b4928 ea07f3c0 f1510c40 000f6e66 d2f63000 
> >        d2f63000 ed88c550 f1510c40 000f6e66 d2f63000 d2f63000 ed062220 ed88c550 
> >        d2f63c70 b139a97b ed062224 efef8df8 ed062224 ed88c550 d2f63000 0000385a 
> > Call Trace:
> >  [<b139a97b>] __mutex_lock_slowpath+0x59/0xb0
> >  [<b139a9d7>] .text.lock.mutex+0x5/0x14
> >  [<b10bb24f>] __log_wait_for_space+0x53/0xb4
> >  [<b10b67b4>] start_this_handle+0x100/0x617
> >  [<b10b6d86>] journal_start+0xbb/0xe0
> >  [<b10ae10e>] ext3_journal_start_sb+0x29/0x4a
> >  [<b10a8d9f>] ext3_dirty_inode+0x2a/0xaf
> >  [<b1080171>] __mark_inode_dirty+0x2a/0x19e
> >  [<b107784a>] touch_atime+0x79/0x9f
> >  [<b103fda5>] do_generic_mapping_read+0x370/0x480
> >  [<b1040747>] __generic_file_aio_read+0xf0/0x205
> >  [<b1040896>] generic_file_aio_read+0x3a/0x46
> >  [<b105d919>] do_sync_read+0xbb/0xf1
> >  [<b105e2c1>] vfs_read+0xa4/0x166
> >  [<b105e6c1>] sys_read+0x3d/0x64
> >  [<b1002e1b>] syscall_call+0x7/0xb
> 
> Confused.  What has this to do with /proc?

/me assumed... with usual result.

