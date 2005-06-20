Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVFTARo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVFTARo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 20:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVFTARo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 20:17:44 -0400
Received: from jynx.3ti.be ([217.22.63.77]:61892 "EHLO horsea.3ti.be")
	by vger.kernel.org with ESMTP id S261347AbVFTARl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 20:17:41 -0400
Date: Mon, 20 Jun 2005 02:17:38 +0200 (CEST)
From: Dag Wieers <dag@wieers.com>
To: linux-kernel@vger.kernel.org
Subject: Block device layer freezing block device access ?
Message-ID: <Pine.LNX.4.63.0506200209000.3085@horsea.3ti.be>
User-Agent: Mutt/1.2.5.1i
X-Mailer: Ximian Evolution 1.0.5
Organization: 3TI Web Hosting Services
X-Extra: We know Linux is the best. It can do infinite loops in five seconds. - Linus Torvalds
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got an (apparently) broken disk. But I see the following behaviour.
The kernel reads the partition table without problems and then has some 
unrecoverable errors.

After the system has booted, the disk has become inaccessible, but it 
appears that the driver/block device layer has decided to make the disk 
inaccessible, as I can't even access the partition table anymore (which 
was previously accessible during boot).

So I was wondering if there is a mechanism (probably in the block device 
layer, as I see it with 2 different sata chipsets) that decides to declare 
the disk 'dead' ?


The reason I am asking is that if this is true, I'd like to disable 
that to recover whatever is still readable from the disk. And it would 
seem to make more sense to make the media read-only (which is what it 
normally does for filesystems after unrecoverable errors iirc) instead of 
freezing the block device layer.


PS the disk is not being accessed or mounted at bootup, I'm booting from a 
rescue image. So the only access (I think) is happening is reading the 
partition table.


PS2 I've looked at the kernel-parameters file, but I think it is out-dated 
so no option being in there probably doesn't mean it's not impossible.


PS3 Thanks for reminding me that taking regular backups and using RAID is 
a wonderful thing, unfortunately that doesn't help me now, does it ? :) I 
have an older backup anyway, but would prefer to recover whatever is 
newer.

Thanks in advance for your help.

Kind regards,
--   dag wieers,  dag@wieers.com,  http://dag.wieers.com/   --
[all I want is a warm bed and a kind word and unlimited power]
