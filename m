Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261478AbSJUSFK>; Mon, 21 Oct 2002 14:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261483AbSJUSFJ>; Mon, 21 Oct 2002 14:05:09 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:36276 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S261478AbSJUSFI>;
	Mon, 21 Oct 2002 14:05:08 -0400
Message-ID: <3DB44316.6010204@candelatech.com>
Date: Mon, 21 Oct 2002 11:10:30 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PoorMan's San
References: <20021021173141.GA22824@rdlg.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert L. Harris wrote:
> 
>   Back on the Kernel list after a long hiatis.  Need some experienced
> optinions.
> 
> Current Setup:
> 
> Linux Legato Backup server  (E1000 nic)   Linux-2.4.19-pre4
> 5xLinux NFS servers         (E1000 nic)   Linux-2.4.19-pre4
> 
> Legato mounts the NFS shares over a Gig ether and uses them as backup
> media for non-offsite/non-longterm.  This works very well when NFS
> behaves.
> 
> The probems is that every now and then the network/nfs just hang up for
> a while and gets VERY slow.  Some research has been done and it seems
> that the PCI latency is part of the problem, especially when IDE Raid
> hits the disks hard, this can overrun the buffers on the GigE card.
> 
> I've got a test NFS server coming in and will look at upgrading the
> kernel to 2.4.19-pre11 as there were some bugs associated with E1000 and
> NFS I saw in pre-[7-9] area. I'm also considering trying to use
> Network Block Device instead of NFS.  Has anyone tried this?
> 
> Any suggestions that doesn't involve hitting up a non-existant budget?
> 
> 
> Robert

Have you increased the e1000 Rx and Tx descriptors?

Could try the e1000 NAPI patch as well...

Ben



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


