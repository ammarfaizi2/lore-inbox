Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVG0MOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVG0MOG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 08:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVG0MOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 08:14:06 -0400
Received: from tornado.reub.net ([202.89.145.182]:27800 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S262219AbVG0MOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 08:14:00 -0400
Message-ID: <42E77A86.6010308@reub.net>
Date: Thu, 28 Jul 2005 00:13:58 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.0+ (Windows/20050725)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm2
References: <fa.gdh870p.1pmsr31@ifi.uio.no>
In-Reply-To: <fa.gdh870p.1pmsr31@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/07/2005 9:45 a.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm2/
> 
> 
> - Lots of fixes and updates all over the place.  There are probably over 100
>   patches here which need to go into 2.6.13.
> 
> - A reminder that -mm commit activity may be monitored by subscribing to
>   the mm-commits list.  Do
> 
> 	echo subscribe mm-commits | mail majordomo@vger.kernel.org
> 
> 
> 
> 
> Changes since 2.6.13-rc3-mm1:

A few more warnings in mostly the reiser4 code in this one compared to -mm1:


   LD      fs/ramfs/ramfs.o
   LD      fs/ramfs/built-in.o
   LD      fs/reiser4/built-in.o
   CC [M]  fs/reiser4/debug.o
In file included from fs/reiser4/plugin/plugin.h:26,
                  from fs/reiser4/jnode.h:19,
                  from fs/reiser4/lock.h:16,
                  from fs/reiser4/context.h:15,
                  from fs/reiser4/debug.c:32:
fs/reiser4/plugin/node/node40.h:83:5: warning: "GUESS_EXISTS" is not defined
   CC [M]  fs/reiser4/jnode.o


about 20 or so times during this part of the compilation, however it never 
quite bombs out.

and this one:


In file included from fs/reiser4/plugin/plugin.h:26,
                  from fs/reiser4/jnode.h:19,
                  from fs/reiser4/seal.c:42:
fs/reiser4/plugin/node/node40.h:83:5: warning: "GUESS_EXISTS" is not defined
fs/reiser4/seal.c:212:5: warning: "REISER4_DEBUG_OUTPUT" is not defined
   CC [M]  fs/reiser4/dscale.o
   CC [M]  fs/reiser4/flush_queue.o


   CC      net/ipv4/netfilter/ip_conntrack_core.o
net/ipv4/netfilter/ip_conntrack_core.c:726:5: warning: 
"CONFIG_IP_NF_CONNTRACK_MARK" is not defined
   CC      net/ipv4/netfilter/ip_conntrack_proto_generic.o


   CC      drivers/scsi/aic7xxx/aic7xxx_core.o
In file included from drivers/scsi/aic7xxx/aic7xxx_core.c:48:
drivers/scsi/aic7xxx/aicasm/aicasm_insformat.h:46:5: warning: "BYTE_ORDER" is 
not defined
drivers/scsi/aic7xxx/aicasm/aicasm_insformat.h:46:19: warning: "LITTLE_ENDIAN" 
is not defined
drivers/scsi/aic7xxx/aicasm/aicasm_insformat.h:64:5: warning: "BYTE_ORDER" is 
not defined
drivers/scsi/aic7xxx/aicasm/aicasm_insformat.h:64:19: warning: "LITTLE_ENDIAN" 
is not defined
drivers/scsi/aic7xxx/aicasm/aicasm_insformat.h:82:5: warning: "BYTE_ORDER" is 
not defined
drivers/scsi/aic7xxx/aicasm/aicasm_insformat.h:82:19: warning: "LITTLE_ENDIAN" 
is not defined




reuben

