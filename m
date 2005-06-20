Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVFTCme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVFTCme (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 22:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVFTCme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 22:42:34 -0400
Received: from jynx.3ti.be ([217.22.63.77]:60106 "EHLO horsea.3ti.be")
	by vger.kernel.org with ESMTP id S261244AbVFTCm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 22:42:28 -0400
Date: Mon, 20 Jun 2005 04:42:25 +0200 (CEST)
From: Dag Wieers <dag@wieers.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Block device layer freezing block device access ? (follow-up)
In-Reply-To: <Pine.LNX.4.63.0506200209000.3085@horsea.3ti.be>
Message-ID: <Pine.LNX.4.63.0506200437290.3085@horsea.3ti.be>
References: <Pine.LNX.4.63.0506200209000.3085@horsea.3ti.be>
User-Agent: Mutt/1.2.5.1i
X-Mailer: Ximian Evolution 1.0.5
Organization: 3TI Web Hosting Services
X-Extra: We know Linux is the best. It can do infinite loops in five seconds. - Linus Torvalds
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2005, Dag Wieers wrote:

> 
> I've got an (apparently) broken disk. But I see the following behaviour.
> The kernel reads the partition table without problems and then has some 
> unrecoverable errors.
> 
> After the system has booted, the disk has become inaccessible, but it 
> appears that the driver/block device layer has decided to make the disk 
> inaccessible, as I can't even access the partition table anymore (which 
> was previously accessible during boot).
> 
> So I was wondering if there is a mechanism (probably in the block device 
> layer, as I see it with 2 different sata chipsets) that decides to declare 
> the disk 'dead' ?

Using Knoppix instead of a Fedora rescue image, I was able to do a reverse 
dd_rescue and already recovered 25GB from the 160GB disk, it now is having 
some (155 now) bad blocks, but I hope it recovers from that (as it already 
managed to do that after the first 55 bad blocks).

Still I'm wondering why on boot it is able to read the partition table, 
but not when booted. Knoppix has the same issue.

--   dag wieers,  dag@wieers.com,  http://dag.wieers.com/   --
[all I want is a warm bed and a kind word and unlimited power]
