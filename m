Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbTJGXnx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 19:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbTJGXnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 19:43:53 -0400
Received: from [66.212.224.118] ([66.212.224.118]:42254 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S263018AbTJGXnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 19:43:51 -0400
Date: Tue, 7 Oct 2003 19:43:40 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Domen Puncer <domen@coderock.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x on 2.6.0-test3->test6 slow
In-Reply-To: <200310070949.31220.domen@coderock.org>
Message-ID: <Pine.LNX.4.53.0310071349560.19396@montezuma.fsmlabs.com>
References: <200310061529.56959.domen@coderock.org> <200310070144.47822.domen@coderock.org>
 <Pine.LNX.4.53.0310062016340.19396@montezuma.fsmlabs.com>
 <200310070949.31220.domen@coderock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Domen Puncer wrote:

> > What is your link peer?
> 
> Not native english speaker, but if "link peer"  is the remote end, then this is a
> friend's computer. (and a hub is between computers)

Ok in this case it would be the hub, sometimes these aren't the best when 
it comes to advertising capabilities.

> # strace mii-tool eth0
> execve("/sbin/mii-tool", ["mii-tool", "eth0"], [/* 37 vars */]) = 0
> socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 3
> ioctl(3, 0x89f0, 0x804b460)             = -1 EOPNOTSUPP (Operation not supported)
> write(2, "SIOCGMIIPHY on \'eth0\' failed: Op"..., 54SIOCGMIIPHY on 'eth0' failed: Operation not supported
> ) = 54
> close(3)                                = 0

Could you try updating your mii-tool please.

#define SIOCGMIIREG	0x8948		/* Read MII PHY register.	*/

I'm not sure what your current binary is doing. I have the following 
version;

Name        : net-tools                    Relocations: (not relocateable)
Version     : 1.60                              Vendor: Red Hat, Inc.
Release     : 12                            Build Date: Tue 11 Feb 2003 09:33:32 AM EST
Install Date: Sat 19 Apr 2003 11:57:08 AM EDT      Build Host: tweety.devel.redhat.com
Group       : System Environment/Base       Source RPM: net-tools-1.60-12.src.rpm
Size        : 611073                           License: GPL
Signature   : DSA/SHA1, Mon 24 Feb 2003 01:37:21 AM EST, Key ID 219180cddb42a60e
Packager    : Red Hat, Inc. <http://bugzilla.redhat.com/bugzilla>
Summary     : Basic networking tools.
Description :
The net-tools package contains basic networking tools, including
ifconfig, netstat, route, and others.
