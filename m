Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVDEMJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVDEMJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 08:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVDEMJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 08:09:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28644 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261705AbVDEMJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 08:09:42 -0400
Message-ID: <42527FF6.1080502@pobox.com>
Date: Tue, 05 Apr 2005 08:09:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: Arjan van de Ven <arjan@infradead.org>, Ian Campbell <ijc@hellion.org.uk>,
       Sven Luther <sven.luther@wanadoo.fr>, "Theodore Ts'o" <tytso@mit.edu>,
       Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 copyright notice.
References: <20050404182753.GC31055@pegasos> <20050404191745.GB12141@kroah.com> <20050404192945.GB1829@pegasos> <20050404205527.GB8619@thunk.org> <20050404211931.GB3421@pegasos> <1112689164.3086.100.camel@icampbell-debian> <20050405083217.GA22724@pegasos> <1112690965.3086.107.camel@icampbell-debian> <20050405091144.GA18219@lst.de> <1112693287.6275.30.camel@laptopd505.fenrus.org> <20050405093258.GA18523@lst.de>
In-Reply-To: <20050405093258.GA18523@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Tue, Apr 05, 2005 at 11:28:07AM +0200, Arjan van de Ven wrote:
>>One of the sticking points will be how people get the firmware; I can
>>see the point of a kernel-distributable-firmware project related to the
>>kernel (say on kernel.org) which would provide a nice collection of
>>distributable firmwares (and is appropriately licensed). Without such
>>joint infrastructure things will always be a mess and in that context I
>>can see the point of the driver authors not immediately wanting to
>>switch exclusively. Simply because they'll get swamped with email about
>>how the driver doesn't work...
> 
> 
> I agree.  And that really doesn't need a lot of infrastructure,
> basically just a tarball that unpacks to /lib/firmware, maybe a specfile
> and debian/ dir in addition.


At the moment there is -zero- infrastructure that would allow my tg3 to 
continue working, when I upgrade to a tg3 driver with external firmware.

The user has to put a file in some location manually.

That's a complete non-starter, from a usability standpoint.

Further, several firmwares, including tg3, are really a collection of 
bits of information:  .text, .bss, and random variables (start addr, 
image size, ...).  The current interface is complete crap for this sort 
of setup.

The firmware loader really needs to be loading -archives- not individual 
files.

We are a -long- way from moving the firmware out of the tg3 source code.

	Jeff


