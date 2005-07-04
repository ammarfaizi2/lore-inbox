Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVGDGQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVGDGQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 02:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVGDGQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 02:16:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:50089 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261440AbVGDGP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 02:15:59 -0400
Date: Mon, 4 Jul 2005 08:17:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Lenz Grimmer <lenz@grimmer.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050704061713.GA1444@suse.de>
References: <9a8748490507031832546f383a@mail.gmail.com> <42C8D06C.2020608@grimmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C8D06C.2020608@grimmer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04 2005, Lenz Grimmer wrote:
> > I'll be working on adding sysfs stuff to it tomorrow so it's generally
> > useful (at least for monitoring things - not yet for parking disk
> > heads).
> 
> Maybe there is some kind of all-purpose ATA command that instructs the
> disk drive to park the heads? Jens, could you give us a hint on how a
> userspace application would do that?

Dunno if there's something that explicitly only parks the head, the best
option is probably to issue a STANDBY_NOW command. You can test this
with hdparm -y.

Generel observation on this driver - why isn't it just contained in user
space? You need to do the monitoring and sending of ide commands from
there anyways, I don't see the point of putting it in the kernel.

-- 
Jens Axboe

