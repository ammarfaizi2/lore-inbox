Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267336AbSLKW0l>; Wed, 11 Dec 2002 17:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267337AbSLKW0l>; Wed, 11 Dec 2002 17:26:41 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:30148
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267336AbSLKW0k>; Wed, 11 Dec 2002 17:26:40 -0500
Subject: Re: NFS mounted rootfs possible via PCMCIA NIC ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Schaufler <andreas.schaufler@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212112253.57325.andreas.schaufler@gmx.de>
References: <200212112253.57325.andreas.schaufler@gmx.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 23:12:00 +0000
Message-Id: <1039648320.18467.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 21:53, Andreas Schaufler wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello list,
> 
> I am trying to configure a notebook with a PCMCIA NIC to boot over network. 
> (kernel 2.4.20)
> In order to accomplish this I passed over the neccessary configuration 
> paramters through the boot loader (ip, root, nfsroot)
> 
> The problem is: When the kernel is booting it is trying to configure the 
> Network interface, before it has been activated.

PCMCIA relies in part on user space. You can do this, it involves
building a large initrd with a dhcp client on it that sets up pcmcia,
then nfs mounts stuff, then pivot_root()'s into it. Its not exactly
trivial

