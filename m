Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317404AbSHTWGT>; Tue, 20 Aug 2002 18:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317415AbSHTWGS>; Tue, 20 Aug 2002 18:06:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20233 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317404AbSHTWGR>;
	Tue, 20 Aug 2002 18:06:17 -0400
Message-ID: <3D62BE48.8050102@mandrakesoft.com>
Date: Tue, 20 Aug 2002 18:10:16 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anders Gustafsson <andersg@0x63.nu>
CC: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
       torvalds@transmeta.com
Subject: Re: [PATCH] __devexit_p in drivers/net/tulip/de2104x.c
References: <20020820133248.GA577@h55p111.delphi.afb.lu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Gustafsson wrote:
> Adds __devexit_p to de_remove_one in drivers/net/tulip/de2104x.c to make it
> possible to compile it with new binutils

Again, de_remove_one is __exit for a reason:  it's not a board people 
are hotplugging.

Look at the fix I made to 2.5's include/linux/init.h recently, though -- 
applying just the last hunk of your patch should hopefully no longer 
cause a warning.

	Jeff


