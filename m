Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161180AbWJDPMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161180AbWJDPMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161215AbWJDPMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:12:36 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:52817 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161180AbWJDPMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:12:35 -0400
Subject: Re: Lock recursion deadlock detected
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Nick Austin <nick.austin@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8a6316160610032129red27121rfceb223e04dc88a@mail.gmail.com>
References: <8a6316160610032129red27121rfceb223e04dc88a@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 15:12:31 +0200
Message-Id: <1159967551.2792.2.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 21:29 -0700, Nick Austin wrote:
> I have the following in my dmesg:
> 
> $ uname -a
> Linux frank 2.6.17-1.2174_FC5 #1 SMP Tue Aug 8 15:30:44 EDT 2006
> x86_64 x86_64 x86_64 GNU/Linux
> 
> It should be noted that lockd failed on this server at the same time.
> 
> Many entries like the flowing occurred on my NFS clients at the same time:
> do_vfs_lock: VFS is out of sync with lock manager!
> do_vfs_lock: VFS is out of sync with lock manager!
> lockd: server 192.168.100.17 not responding, timed out
> lockd: server 192.168.100.17 not responding, timed out
> 
> I'm reporting this, just as the error message asks. :)
> 
> Thanks!

Thanks for reporting; however this bug has been fixed in .18-rc5,
upgrading your kernel should rid you of this nuisance.


