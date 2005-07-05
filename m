Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVGEMxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVGEMxw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 08:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVGEMxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 08:53:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18667 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261821AbVGEMsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 08:48:53 -0400
Subject: Re: [git patches] IDE update
From: Jens Axboe <axboe@suse.de>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: =?ISO-8859-1?Q?Andr=E9?= Tomt <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <42CA7EA9.1010409@rainbow-software.org>
References: <200507042033.XAA19724@raad.intranet>
	 <42C9C56D.7040701@tomt.net> <42CA5A84.1060005@rainbow-software.org>
	 <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org>
	 <20050705104208.GA20620@suse.de>  <42CA7EA9.1010409@rainbow-software.org>
Content-Type: text/plain
Date: Tue, 05 Jul 2005 14:51:39 +0200
Message-Id: <1120567900.12942.8.camel@linux>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-05 at 14:35 +0200, Ondrej Zary wrote:
> >>>>2.4.26
> >>>>root@pentium:/home/rainbow# time dd if=/dev/hda of=/dev/null bs=512
> >>>>count=1048576
> >>>>1048576+0 records in
> >>>>1048576+0 records out
> >>>>
> >>>>real    0m23.858s
> >>>>user    0m1.750s
> >>>>sys     0m15.180s
> >>>
> >>>
> >>>Perhaps some read-ahead bug. What happens if you use bs=128k for
> >>>instance?
> >>>
> >>
> >>Nothing - it's still the same.
> >>
> >>root@pentium:/home/rainbow# time dd if=/dev/hda of=/dev/null bs=128k 
> >>count=4096
> >>4096+0 records in
> >>4096+0 records out
> >>
> >>real    0m32.832s
> >>user    0m0.040s
> >>sys     0m15.670s
> > 
> > 
> > Can you post full dmesg of 2.4 and 2.6 kernel boot? What does hdparm
> > -I/-i say for both kernels?
> > 
> 
> The 2.4.26 kernel is the one from Slackware 10.0 bootable install CD.
> dmesg outputs attached, hdparm -i and hdparm -I shows the same in both
> kernels (compared using diff) - attached too.

Ok, looks alright for both. Your machine is quite slow, perhaps that is
showing the slower performance. Can you try and make HZ 100 in 2.6 and
test again? 2.6.13-recent has it as a config option, otherwise edit
include/asm/param.h appropriately.


-- 
Jens Axboe <axboe@suse.de>

