Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbUCSX0C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263145AbUCSX0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:26:02 -0500
Received: from [62.81.186.19] ([62.81.186.19]:47755 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S263144AbUCSXZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:25:59 -0500
Date: Sat, 20 Mar 2004 00:25:48 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Jens Axboe <axboe@suse.de>
Cc: "J.A. Magallon" <jamagallon@able.es>, Eric Valette <eric.valette@free.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm2 : Badness in elv_requeue_request at drivers/block/elevator.c:157
Message-ID: <20040319232548.GA29690@werewolf.able.es>
References: <40596FC5.3080703@free.fr> <20040318100222.GE22234@suse.de> <20040318100606.GG22234@suse.de> <20040318231957.GA3867@werewolf.able.es> <20040319073716.GX22234@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040319073716.GX22234@suse.de> (from axboe@suse.de on Fri, Mar 19, 2004 at 08:37:17 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.19, Jens Axboe wrote:
> On Fri, Mar 19 2004, J.A. Magallon wrote:
> > 
> > On 03.18, Jens Axboe wrote:
> > > On Thu, Mar 18 2004, Jens Axboe wrote:
> > > > On Thu, Mar 18 2004, Eric Valette wrote:
> > > > > I have this message two times as I have two adaptec controllers...
> > > > > 
> > 
> > I have a similar but different place oops. My box was dog slow with -mm2,
> > and syslog was flooded with:
> > 
> > Mar 18 20:00:00 werewolf kernel: Badness in elv_remove_request at drivers/block/elevator.c:249
> > Mar 18 20:00:00 werewolf kernel: Call Trace:
> > Mar 18 20:00:00 werewolf kernel:  [elv_remove_request+156/160] elv_remove_request+0x9c/0xa0
> 
> Tell me a bit about your io setup please, ide/scsi, raid, what?
> 

Simple scsi (no raid, no md), on an 2940.
Anyways, the patch you posted made everything work fine again.
Thanks. 

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Community) for i586
Linux 2.6.5-rc1-jam2 (gcc 3.4.0 (Mandrake Linux 10.0 3.4.0-0.4mdk))
