Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263900AbTEOEJM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 00:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263901AbTEOEJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 00:09:11 -0400
Received: from dsl093-135-135.sfo2.dsl.speakeasy.net ([66.93.135.135]:6272
	"EHLO jm.kir.nu") by vger.kernel.org with ESMTP id S263900AbTEOEJK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 00:09:10 -0400
Date: Wed, 14 May 2003 21:21:43 -0700
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       David Gibson <hermes@gibson.dropbear.id.au>,
       Benjamin Reed <breed@almaden.ibm.com>,
       Javier Achirica <achirica@ttd.net>,
       James Morris <jmorris@intercode.com.au>
Subject: Re: CryptoAPI and WEP/stream ciphers (was: airo and firmware upload)
Message-ID: <20030515042143.GA1918@jm.kir.nu>
References: <20030514211222.GA10453@bougret.hpl.hp.com> <3EC2BDEC.6020401@pobox.com> <20030514233235.GA11581@bougret.hpl.hp.com> <20030514234359.GB9898@suse.de> <3EC2D6FB.5050700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC2D6FB.5050700@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 07:53:31PM -0400, Jeff Garzik wrote:

> airo and HostAP do indeed need to use CryptoAPI not reimplement their 
> own crypto, though...

I tried to change my WEP implementation to use CryptoAPI, but that ended
up in problems.. If I understood correctly, current CryptoAPI supports
only block ciphers(?). However, WEP uses RC4 as a stream cipher. This
does not seem to fit the cipher definition in CryptoAPI. One might be
able to implement it as an compression algorithm (encrypt as decompress,
since it adds IV and ICV; and decrypt as compress). However, this
certainly does not sound very reasonable.. Another alternative would be
to add support for stream ciphers into CryptoAPI.

Do you think that it would still be required to get rid of the own WEP
implementation in the Host AP driver before including it into the kernel
tree? Would this mean that someone would first need to add support for
stream ciphers into CryptoAPI? Any change of that happening for Linux
2.6.x?

And one more question before using more time with WEP implementation..
Is someone already working with stream cipher support for CryptoAPI?

-- 
Jouni Malinen                                            PGP id EFC895FA
