Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTDTTOd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 15:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263681AbTDTTOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 15:14:33 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:30945 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S263680AbTDTTOb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 15:14:31 -0400
Date: Sun, 20 Apr 2003 21:26:16 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Gibson <david@gibson.dropbear.id.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: firmware separation filesystem (fwfs)
Message-ID: <20030420192616.GB2022@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030416163641.GA2183@ranty.ddts.net> <1050508028.28586.126.camel@dhcp22.swansea.linux.org.uk> <20030417012321.GB9219@zax> <1050585122.31390.25.camel@dhcp22.swansea.linux.org.uk> <20030419204138.GC638@ranty.ddts.net> <1050789163.3955.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050789163.3955.8.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 19, 2003 at 10:52:44PM +0100, Alan Cox wrote:
> On Sad, 2003-04-19 at 21:41, Manuel Estrada Sainz wrote:
> > > fwfs is a broken idea because it leaves the data in kernel space. On
> > > a giant IBM monster maybe nobody cares about a few hundred K of cached
> > > firmware in the kernel, but the rest of us happen to run real world
> > > computers.
> > 
> >  Many drivers currently include this same data in kernel space, in in
> >  headers, what I am trying to do is make it easy for them to support
> >  fwfs (or whatever it becomes in the end). 
> 
> So what is the value in changing them to this, then changing them again
> to put the firmware in userspace ? Surely you'd be better off writing
> a generally usable request_firmware() hotplug interface ?

  Sorry, I modify plans in my head with the feedback, but am probably
  not telling my new plans very well as I go along.

  My current plan is actualy making a request_firmware() hotplug
  interface. What I am still not sure about is if it should be build
  around some evolution of fwfs, sysfs binary support or something even
  simpler. In any case, I'll try to make the same interface, so even if
  one is taken and later found to be wrong, drivers won't have to be
  rewritten.
 
  I plan to implement at least two alternatives, the one around fwfs and
  the one around sysfs, so we can compare the merits and limitations of
  each looking at working code. If there is interest in an even simpler
  alternative or the other two are found to be wrong I'll do it.

  Specially if you (Alan) don't like the sysfs alternative either, I'll
  try to make the third alternative based on your feedback.

  I am really more interested in finding a good way to handle firmware
  than in pushing any actual implementation in special.

  Have a nice day

  	Manuel

  PS: I'll be away most of the week, I'll respond to any new feedback
  and get back to coding when I come back.
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
