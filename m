Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbUBZHtX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 02:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbUBZHtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 02:49:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3300 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262719AbUBZHtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 02:49:19 -0500
Message-ID: <403DA4F0.6060109@pobox.com>
Date: Thu, 26 Feb 2004 02:49:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: "Mukker, Atul" <Atulm@lsil.com>, "'Matt Domsch'" <Matt_Domsch@dell.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [SUBJECT CHANGE]: megaraid unified driver version 2.20.0.0-al
 pha1
References: <0E3FA95632D6D047BA649F95DAB60E57033BC3EA@exa-atlanta.se.lsil.com> <20040226074317.GC32246@devserv.devel.redhat.com>
In-Reply-To: <20040226074317.GC32246@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> BTW it would be really nice if the various raid controller drivers could
> come up with a joint common IOCTL api since it seems every raid controller
> driver right now has a largely overlapping but yet different set of ioctls.


Well.....   we should be moving away from ioctls for this.

For addressing raid arrays, inject REQ_SPECIAL requests directly into 
the request_queue.

For addressing elements above raid array level (such as when creating 
new arrays, etc.) there should be a character device that talks to the 
host driver.

And please let's not bring that godawful SNIA API into the kernel ;-)

	Jeff


