Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWGXTrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWGXTrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 15:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWGXTrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 15:47:04 -0400
Received: from pat.uio.no ([129.240.10.4]:42140 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751351AbWGXTrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 15:47:01 -0400
Subject: Re: NFS errors
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: c-otto@gmx.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060724191540.GD19902@server.c-otto.de>
References: <20060724191540.GD19902@server.c-otto.de>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 15:46:48 -0400
Message-Id: <1153770408.5723.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.831, required 12,
	autolearn=disabled, AWL 1.17, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-24 at 21:15 +0200, Carsten Otto wrote:
> Hello!
> 
> My computer uses another server to boot and run with NFS root.
> During normal work I notice strange NFS errors.
> Please tell me what causes these errors and how I can resolve them.
> 
> Example 1:
> I executed these commands directly after another.
> 
> cotto@carsten-otto:/home/cotto/.mozilla/firefox$ l
> ls: .: Permission denied
> cotto@carsten-otto:/home/cotto/.mozilla/firefox$ l
> total 8.0K
> drwx------ 6 cotto users 4.0K Jul 24 21:03 eir51v0r.default
> ?--------- ? ?     ?        ?            ? la2v5nug.default
> ?--------- ? ?     ?        ?            ? pluginreg.dat
> -rw-r--r-- 1 cotto users   94 Jul 24 21:03 profiles.ini
> ?--------- ? ?     ?        ?            ? v1q37ws3.default
> cotto@carsten-otto:/home/cotto/.mozilla/firefox$ l
> total 20K
> drwx------ 6 cotto users 4.0K Jul 24 21:03 eir51v0r.default
> drwx------ 3 cotto users 4.0K Jul 24 21:03 la2v5nug.default
> -rw------- 1 cotto users  286 Jul 24 20:57 pluginreg.dat
> -rw-r--r-- 1 cotto users   94 Jul 24 21:03 profiles.ini
> drwx------ 6 cotto users 4.0K Jul 24 21:04 v1q37ws3.default
> 
> Example 2:
> GAIM shows "Could not read file: somewhere.txt" when scrolling through
> the list of archived conversations.
> 
> Example 3:
> Firefox crashes a lot during normal surfing, sometimes even the profile
> gets lost.
> 
> Example 4:
> I get a lot of "do_vfs_lock: VFS is out of sync with lock manager!"
> during the day.
> 
> Example 5:
> Some ./configure && make runs do not complete, because files are
> missing. Running the command in a chroot locally on the server (which
> has the disk drives) everything works.
> 
> The client (without disk drives) uses 2.6.17.6, but I have this problem
> with several kernel versions.
> The kernel is running 2.6.18-rc1-mm2, but here again the problem occurs
> with several versions.
> The client runs Debian testing, the server runs Debian stable (Sarge).
> The network connection in between is:
> (Client) Intel e1000 PCI <-> HP Procurve 2824 (Gigabit) <-> Intel e1000 PCIe (Server)
> 
> x:~# rpcinfo -p server
>    Program Vers Proto   Port
>     100000    2   tcp    111  portmapper
>     100000    2   udp    111  portmapper
>     100003    2   udp   2049  nfs
>     100003    3   udp   2049  nfs
>     100003    4   udp   2049  nfs
>     100003    2   tcp   2049  nfs
>     100003    3   tcp   2049  nfs
>     100003    4   tcp   2049  nfs
>     100021    1   udp  32768  nlockmgr
>     100021    3   udp  32768  nlockmgr
>     100021    4   udp  32768  nlockmgr
>     100021    1   tcp  43642  nlockmgr
>     100021    3   tcp  43642  nlockmgr
>     100021    4   tcp  43642  nlockmgr
>     100005    1   udp    779  mountd
>     100005    1   tcp    782  mountd
>     100005    2   udp    779  mountd
>     100005    2   tcp    782  mountd
>     100005    3   udp    779  mountd
>     100005    3   tcp    782  mountd
>     100024    1   udp    877  status
>     100024    1   tcp    880  status
> 
> I enabled nfs4 in the kernels, but do not use it yet
> (as a lot of changes are needed in userspace).
> 
> mount shows:
> server:/export on / type nfs (rw,soft,tcp,intr)
> 
> Thanks a lot,

Have you set 'no_subtree_check' in your export options on the server? If
not, please try doing so.

cheers,
  Trond

