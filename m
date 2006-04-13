Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWDMPPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWDMPPq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 11:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbWDMPPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 11:15:45 -0400
Received: from 195-23-92-73.nr.ip.pt ([195.23.92.73]:42728 "EHLO noori.ip.pt")
	by vger.kernel.org with ESMTP id S1750837AbWDMPPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 11:15:45 -0400
Subject: Documentation issue on 2.6
From: Marcos Daniel Marado Torres <Marcos.Marado@sonae.com>
Reply-To: Marcos.Marado@sonae.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Sonaecom ISP
Date: Thu, 13 Apr 2006 16:17:13 +0100
Message-Id: <1144941433.14691.50.camel@noori.ip.pt>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation issue on 2.6:

> --- Documentation/Changes	2006-03-21 23:55:52.000000000 +0000
> +++ Documentation/Changes.new	2006-04-12 20:52:39.000000000 +0100
> @@ -53,7 +53,7 @@
>  o  module-init-tools      0.9.10                  # depmod -V
>  o  e2fsprogs              1.29                    # tune2fs
>  o  jfsutils               1.1.3                   # fsck.jfs -V
> -o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs
> +o  reiserfsprogs          3.6.3                   # reiserfsck -V
>  o  xfsprogs               2.6.0                   # xfs_db -V
>  o  pcmciautils            004
>  o  pcmcia-cs              3.1.21                  # cardmgr -V

Please apply this patch, since in recent versions of reiserfsprogs
`reiserfsck -V 2>&1|grep reiserfsprogs` won't return nothing.

As an example: 

[root@noori ~]# reiserfsck -V
reiserfsck 3.6.19 (2003 www.namesys.com)

[root@noori ~]#          

P.S. -> For replies, please CC me, since I'm no longer subscribed to
LKML.

-- 
Marcos Marado <Marcos.Marado@sonae.com>
Sonaecom ISP
$ cat sig.pl
''=~('(?{'.('^)@@*@'^'.[).^`').'"'.('`@@?@~//[*;)@`//)@|'^'-).[`<@@(^^[`.@@[)^').',$/})')
$
> 
