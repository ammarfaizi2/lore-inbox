Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVDVNj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVDVNj2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 09:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVDVNj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 09:39:28 -0400
Received: from pat.uio.no ([129.240.130.16]:42974 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261716AbVDVNjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 09:39:24 -0400
Subject: Re: Crash when unmounting NFS/TCP with -f
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4268EEC9.8010305@ens-lyon.org>
References: <4268EEC9.8010305@ens-lyon.org>
Content-Type: text/plain
Date: Fri, 22 Apr 2005 09:39:10 -0400
Message-Id: <1114177150.10450.49.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.57, required 12,
	autolearn=disabled, AWL 1.38, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 22.04.2005 Klokka 14:32 (+0200) skreiv Brice Goglin:
> Hi Trond,
> 
> I'm using NFS (v2) over TCP (in a SSH tunnel).
> Each time the SSH dies before a umount NFS, I have to umount -f
> and I get a crash (only sysrq works).
> Actually, the crash occurs a few seconds after umount -f.
> 
> It seems that killing SSH by hand does _not_ lead to crash.
> But a long network failure does.
> I remember seeing this bug several times with all stable releases
> from 2.6.7 to 2.6.11. I didn't try with earlier versions.
> 
> I didn't see anything in the logs (after reboot). But I can't be sure
> there was nothing in dmesg since I didn't get a chance to chvt 1 and
> see console messages before rebooting (with sysrq).

I'll try to reproduce. There has just been a discussion about "umount
-f" on the NFS mailing list (nfs@lists.sourceforge.net), where Peter
Cendio said he was seeing the following Oops:

  http://www.cendio.se/~peter/fc3-umount-crash.png

I am unable to reproduce Peter's crash, but I didn't try the scenario
that you describe above.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

