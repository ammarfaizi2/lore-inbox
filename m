Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263856AbTJ1EOh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 23:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbTJ1EOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 23:14:35 -0500
Received: from savages.net ([12.154.202.18]:11682 "EHLO savages.net")
	by vger.kernel.org with ESMTP id S263863AbTJ1EOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 23:14:15 -0500
Message-ID: <3F9DED15.5050806@savages.net>
Date: Mon, 27 Oct 2003 20:14:13 -0800
From: Shaun Savage <savages@savages.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Bob Johnson <livewire@gentoo.org>, linux-kernel@vger.kernel.org,
       edt@aei.ca, nuno.silva@vgertech.com
Subject: Re: kernel 2.6t9 SATA slower than 2.4.20
References: <3F9D402F.9050509@savages.net> <200310271308.53135.livewire@gentoo.org> <20031027181738.GB5335@gtf.org>
In-Reply-To: <20031027181738.GB5335@gtf.org>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have removed the IDE SiI driver now the hdparm buffered disk read are 
now 15M again. So you are right the IDE does give better performance but 
the SCSI SATA does need to be enabled. I Think ;\

Now I am trying to iptables working, then SELinux

Thanks
Shaun


Jeff Garzik wrote:
> On Mon, Oct 27, 2003 at 01:08:46PM -0500, Bob Johnson wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>The Sata driver worked well on my siimage, but lost around 30%-40% performance
>>according to tiobench.
> 
> 
> This is to be expected -- I use a "sledgehammer fix" for the Maxtor and
> Seagate errata -- each transfer is limited to 15 sectors.
> 
> When I get a chance to clean up the SiI driver, the performance will
> indeed increase by a large amount.
> 
> For now, for Silicon Image, I recommend using the
> drivers/ide/pci/siimage.c -- assuming it works for you, of course.
> 
> The libata Silicon Image driver is marked with CONFIG_BROKEN because it
> is fairly easy to lock it up (I need ack some more interrupts).
> 
> 	Jeff
> 
> 
> 
> 


