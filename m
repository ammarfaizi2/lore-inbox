Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVJVQvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVJVQvT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 12:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVJVQvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 12:51:19 -0400
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:36539 "HELO
	web31803.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750704AbVJVQvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 12:51:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=EjOTKUROvnvlNuHosMWd90zKjZxyPP0sVfMubLmqedxsGdvnR7K5vYO6+MCH6iuGyLTuNwk0GvI+U228X9REwXAHEU7CSnntsFTqmOLKZd2nbyWMkOI0aiQNCCKCEYyMGqr/2SIf6P6F67n5GzQWwmXNOFU15ZaQfi6cLV6TTFM=  ;
Message-ID: <20051022165117.95751.qmail@web31803.mail.mud.yahoo.com>
Date: Sat, 22 Oct 2005 09:51:17 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached PHYs)
To: Jeff Garzik <jgarzik@pobox.com>, dougg@torque.net
Cc: Matthew Wilcox <matthew@wil.cx>, Luben Tuikov <luben_tuikov@adaptec.com>,
       Christoph Hellwig <hch@lst.de>, andrew.patterson@hp.com,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <4359A9FE.4010503@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jeff Garzik <jgarzik@pobox.com> wrote:
> Invalid example.  All of the methods listed -- request_queue, netlink, 
> chrdev, sysfs, ioctl -- will work just fine when the root filesystem is 
> on the far side of a SAS expander.  These are just methods of 
> communication, nothing more.

Jeff, why don't you listen from time to time to people who work with
the technology on a daily basis who have experience with it, who
have _insight_ of the technology?  Such insight gives them great
intuition when it comes to design, among other things.

> In your example -- userspace discovery required before root filesystem 
> can be found -- a program running from initrd/initramfs would create an 
> SMP device node, open it, and then proceed with the discovery and 

SMP is part of the protocol, of what the device (PCI) implements.  It is always
there, just like phys.  You do not need to create it from user space. It
will be there for a user process to use, via say SDI.  SDI provides this as
part of the controller.  Read the SDI spec.

Insight of the whole architecture is irreplacable to create good design.

> configuration process, which in turn creates the device nodes necessary 
> to mount the root filesystem.

Also note that everyone does domain discovery in the kernel/FW and not
only for SAS but for other domains (even non-SCSI).  While domain
discovery is in the kernel/FW, _control_ of the domain is given to
user space, via say SDI -- everyone agrees on this.

   Luben

