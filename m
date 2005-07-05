Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVGEKNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVGEKNI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 06:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVGEKNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 06:13:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43494 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261786AbVGEKMz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 06:12:55 -0400
Date: Tue, 5 Jul 2005 12:14:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: =?iso-8859-1?Q?Andr=E9?= Tomt <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
Message-ID: <20050705101414.GB18504@suse.de>
References: <200507042033.XAA19724@raad.intranet> <42C9C56D.7040701@tomt.net> <42CA5A84.1060005@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <42CA5A84.1060005@rainbow-software.org>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05 2005, Ondrej Zary wrote:
> André Tomt wrote:
> >Al Boldi wrote:
> >
> >>Bartlomiej Zolnierkiewicz wrote: {
> >>
> >>>>>On 7/4/05, Al Boldi <a1426z@gawab.com> wrote:
> >>>>>Hdparm -tT gives 38mb/s in 2.4.31
> >>>>>Cat /dev/hda > /dev/null gives 2% user 33% sys 65% idle
> >>>>>
> >>>>>Hdparm -tT gives 28mb/s in 2.6.12
> >>>>>Cat /dev/hda > /dev/null gives 2% user 25% sys 0% idle 73% IOWAIT
> >
> >
> >The "hdparm doesn't get as high scores as in 2.4" is a old discussed to 
> >death "problem" on LKML. So far nobody has been able to show it affects 
> >anything  but that pretty useless quasi-benchmark.
> >
> 
> No, it's not a problem with hdparm. hdparm only shows that there is 
> _really_ a problem:
> 
> 2.6.12
> root@pentium:/home/rainbow# time dd if=/dev/hda of=/dev/null bs=512
> count=1048576
> 1048576+0 records in
> 1048576+0 records out
> 
> real    0m32.339s
> user    0m1.500s
> sys     0m14.560s
> 
> 2.4.26
> root@pentium:/home/rainbow# time dd if=/dev/hda of=/dev/null bs=512
> count=1048576
> 1048576+0 records in
> 1048576+0 records out
> 
> real    0m23.858s
> user    0m1.750s
> sys     0m15.180s

Perhaps some read-ahead bug. What happens if you use bs=128k for
instance?

-- 
Jens Axboe

