Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310448AbSCHSZq>; Fri, 8 Mar 2002 13:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310774AbSCHSZf>; Fri, 8 Mar 2002 13:25:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23813 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310448AbSCHSZX>; Fri, 8 Mar 2002 13:25:23 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Ext2/Ext3 partition label abuse
Date: 8 Mar 2002 10:24:52 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6avlk$umf$1@cesium.transmeta.com>
In-Reply-To: <3C88890C.6010303@mail.externet.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C88890C.6010303@mail.externet.hu>
By author:    Boszormenyi Zoltan <zboszor@mail.externet.hu>
In newsgroup: linux.dev.kernel
> 
> The /proc/partitions "file" lists the partitions in disk-reversed order,
> e.g.:
> 
> /dev/hdc1  ....
> ...
> /dev/hdc10 ...
> /dev/hda1 ...
> ...
> /dev/hda9 ...
> 
> Is there a way to fix this? Yes there is: vendors should not use
> LABEL=XXX method in /etc/fstab. Either use the proper
> device/partition or the UUID. The downside is that fsck messages
> would not be as pretty-printed as now. Or maybe the partitions
> should not be registered in disk-reversed order...
> 

Or maybe mount(8) should signal an error if a label is ambiguous
instead of mounting a random partition.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
