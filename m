Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUIVKSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUIVKSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 06:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUIVKSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 06:18:16 -0400
Received: from open.hands.com ([195.224.53.39]:28056 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S263795AbUIVKSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 06:18:13 -0400
Date: Wed, 22 Sep 2004 11:29:17 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FUSE fusexmp proxy example solves umount problem!
Message-ID: <20040922102917.GA20688@lkcl.net>
References: <20040922004941.GC14303@lkcl.net> <1095845610.2613.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095845610.2613.4.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 11:33:30AM +0200, Arjan van de Ven wrote:
> On Wed, 2004-09-22 at 02:49, Luke Kenneth Casson Leighton wrote:
> > what do people think about a filesystem proxy kernel module?
> > has anyone heard of such a beast already?
> > (which can also do xattrs)
> > 
> > fusexmp.c (in file system in userspace package) does stateless
> > filesystem proxy redirection.
> > 
> > this is a PERFECT solution to the problem of users removing media
> > from drives without warning. 
> 
> eh and the 2.6 kernel doesn't deal with it? 

 nope.
 
 not in the slightest bit: i wish it did!!!

 i'm using 2.6.8 [.1-selinux1 from http://sf.net/projects/selinux]


> It really is supposed to
> deal with it nicely already...

 please tell me how i enable such functionality!


 i remove a usb media, HAL does a umount -lf, konqueror still has
 directory handles open (see report i sent earlier with the little
 program opendir.c which duplicates what konqueror does), then HAL
 does an ioctl("/dev/sdc1", Block_Re_Read_PARTition) which returns 
 an error message "Device or Resource Busy".

 david (hal developer) considers this to be a serious bug in the
 linux kernel because a user action can cause hotplug events to
 not be generated.

 the above ioctl is supposed to cause a hotplug event that will
 allow HAL to remove the volume from its records.

 and it can't.
 
 l.
 
-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

