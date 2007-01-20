Return-Path: <linux-kernel-owner+w=401wt.eu-S932788AbXASXei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932788AbXASXei (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 18:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932807AbXASXei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 18:34:38 -0500
Received: from mail.alkar.net ([195.248.191.95]:60914 "EHLO mail.alkar.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932788AbXASXeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 18:34:37 -0500
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Zan Lynx <zlynx@acm.org>
Subject: Re: linux-2.6.20-rc4-mm1 Reiser4 filesystem freeze and corruption
Date: Sat, 20 Jan 2007 03:34:07 +0300
User-Agent: KMail/1.8.2
Cc: reiserfs-list@namesys.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1169229490.6266.11.camel@oberon>
In-Reply-To: <1169229490.6266.11.camel@oberon>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701200334.07690.vs@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Friday 19 January 2007 20:58, Zan Lynx wrote:
> I have been running 2.6.20-rc2-mm1 without problems, but both rc3-mm1
> and rc4-mm1 have been giving me these freezes.  They were happening
> inside X and without external console it was impossible to get anything,
> plus I was reluctant to test it since the freeze sometimes requires a
> full fsck.reiser4 --build-fs to recover the filesystem.
> 
> But I finally got some output in a console session.  I wasn't able to
> get it all, I made some notes of what I think the problem is.  I may try
> again later once I get netconsole working (netconsole fails as a
> built-in, I'll try it as a module next).
> 
> 1 lock held by pdflush/185:
> #0: (&type->s_umount_key#15) ... writeback_inodes+0x89
> 
> 3 locks held by realsync/12942:
> #0: (&type->s_umount_key#15) at ... __sync_inodes+0x78
> #1: (&mgr->commit_mutex) ... reiser4_txn_end+0x37a
> #2: (&qp->mutex) ... synchronize_qrcu+0x19
> 
> So, I *think* the problem is two locks on s_umount_key#15.  Does that
> sound likely?  I also noticed QRCU may be involved.
> 
> Perhaps someone will look at this and instantly know what the problem
> is.
> 
> If not, I'll be following up with more details like .config and perhaps
> a full sysrq-T dump as soon as that fsck finishes.
> 
yes, please provide more information. Full kernel output at time of freeze is very desirable.
