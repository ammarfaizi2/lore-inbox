Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263038AbVHEOZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbVHEOZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbVHEOZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:25:45 -0400
Received: from mail24.sea5.speakeasy.net ([69.17.117.26]:40667 "EHLO
	mail24.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S263045AbVHEOZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:25:07 -0400
Date: Fri, 5 Aug 2005 10:25:04 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: antoine <antoine@nagafix.co.uk>
cc: linux-kernel@vger.kernel.org, "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: preempt with selinux NULL pointer dereference
In-Reply-To: <1123234785.7889.7.camel@dhcp-192-168-22-217.internal>
Message-ID: <Pine.LNX.4.63.0508051024100.559@excalibur.intercode>
References: <1123234785.7889.7.camel@dhcp-192-168-22-217.internal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2005, antoine wrote:

> After using it for a good few hours, I launched a shell script in a terminal and got the traces below.
> I hope this helps (if not, please let me know how to make it helpful or I'll just stop testing -rc kernels and save myself some time)
>
>
> [ 4788.218951] Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
> [ 4788.218959] <ffffffff80247381>{inode_has_perm+81}
> [ 4788.218971] PGD 2485f067 PUD 0
> [ 4788.218975] Oops: 0000 [1] PREEMPT
> [ 4788.218977] CPU 0
> [ 4788.218979] Modules linked in: parport_pc lp parport eeprom i2c_sensor i2c_viapro i2c_dev i2c_core rfcomm l2cap bluetooth sunrpc ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables dm_mod hotkey container tsdev usbhid yenta_socket rsrc_nonstatic uhci_hcd ehci_hcd shpchp via_ircc irda crc_ccitt
> [ 4788.218995] Pid: 19002, comm: ssh Tainted: G   M  2.6.13-rc5

Which of your modules is non-GPL and can you please remove them and see if 
there's still a problem?



- James
-- 
James Morris
<jmorris@namei.org>
