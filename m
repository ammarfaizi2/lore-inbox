Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263422AbTECUs5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 16:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263423AbTECUs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 16:48:57 -0400
Received: from pat.uio.no ([129.240.130.16]:33189 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263422AbTECUs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 16:48:56 -0400
Date: Sat, 3 May 2003 23:01:21 +0200 (MEST)
From: =?iso-8859-1?Q?P=E5l_Halvorsen?= <paalh@ifi.uio.no>
To: Mark Mielke <mark@mark.mielke.cc>
cc: linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?P=E5l_Halvorsen?= <paalh@ifi.uio.no>,
       miquels@cistron-office.nl
Subject: Re: sendfile
In-Reply-To: <20030502210648.GA5322@mark.mielke.cc>
Message-ID: <Pine.SOL.4.51.0305032253490.18740@fjorir.ifi.uio.no>
References: <Pine.SOL.4.51.0304302102300.12387@ellifu.ifi.uio.no>
 <20030430192809.GA8961@outpost.ds9a.nl> <Pine.SOL.4.51.0304302317590.13406@thrir.ifi.uio.no>
 <20030430221834.GA23109@mark.mielke.cc> <Pine.SOL.4.51.0305010024180.334@niu.ifi.uio.no>
 <20030501042831.GA26735@mark.mielke.cc> <Pine.SOL.4.51.0305012303540.17001@fjorir.ifi.uio.no>
 <3EB1A029.7080708@nortelnetworks.com> <20030502024147.GA523@mark.mielke.cc>
 <3EB1F1CD.4060702@nortelnetworks.com> <20030502210648.GA5322@mark.mielke.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sat, May 03, 2003 at 12:42:59AM +0000, Miquel van Smoorenburg wrote:
> > In article <20030502210648.GA5322@mark.mielke.cc>,
> > Mark Mielke  <mark@mark.mielke.cc> wrote:
> > >One question it raises in my mind, is whether there would be value in
> > >improving write()/send() such that they detect that the userspace
> > >pointer refers entirely to mmap()'d file pages, and therefore no copy
> > >of data from userspace -> kernelspace should be performed.
> > You mean like
> >
>  http://hypermail.idiosynkrasia.net/linux-kernel/archived/2003/week00/0056.html
>
> Yes, definately, and thank you for referring us to work that has already
> been done.
>
> mark

Does this mean that if you memory map a file and send it through TCP,
you'll have no copy operations transfering data from disk to NIC (except
the DMS transfers disk->memory and memory->NIC)?

Does there exist work implementing this also for UDP?

-ph
