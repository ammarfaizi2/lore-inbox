Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbVIWWDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbVIWWDX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 18:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVIWWDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 18:03:23 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:2688 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1750941AbVIWWDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 18:03:23 -0400
Date: Sat, 24 Sep 2005 02:03:02 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic during SysRq-b on Alpha
Message-ID: <20050924020302.A25221@jurassic.park.msu.ru>
References: <43315BEB.3010909@ens-lyon.org> <20050922101259.A29179@jurassic.park.msu.ru> <20050921234232.1034cc02.akpm@osdl.org> <20050922130449.A29503@jurassic.park.msu.ru> <433283E2.20706@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <433283E2.20706@ens-lyon.org>; from Brice.Goglin@ens-lyon.org on Thu, Sep 22, 2005 at 12:13:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 12:13:54PM +0200, Brice Goglin wrote:
> All kernels I tried between 2.6.11 and 2.6.13 with Debian gcc-4.0.1-2
> have a strange bug that does not appear with gcc 3.3 and 3.4
> (non-root ssh sessions are immediately closed).

Confirmed. :-(
This happens with gcc 4.0.1 release and 4.1-20050917 snapshot.
The sshd child process dies with following errors:

Sep 24 01:11:14 den sshd[568]: fatal: mm_send_fd: sendmsg(3): Invalid argument
Sep 24 01:11:14 den sshd[568]: syslogin_perform_logout: logout() returned an error
Sep 24 01:11:14 den sshd[571]: fatal: mm_receive_fd: recvmsg: expected received 1 got 0

At least this gives some clue where to seek...

Ivan.
