Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263033AbVG3KN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbVG3KN0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 06:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263030AbVG3KN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 06:13:26 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:10438 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263033AbVG3KNW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 06:13:22 -0400
Date: Sat, 30 Jul 2005 12:10:42 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, lars.vahlenberg@mandator.com,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Andrew Hutchings <info@a-wing.co.uk>, jgarzik@pobox.com
Subject: Re: [patch 2.6.13-rc3] sis190 driver
Message-ID: <20050730101042.GA22959@electric-eye.fr.zoreil.com>
References: <8141764.1122715931842.JavaMail.www@wwinf0802>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8141764.1122715931842.JavaMail.www@wwinf0802>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal CHAPPERON <pascal.chapperon@wanadoo.fr> :
[...]
> sis190-120 compiles, loads but does not work (sis190_init_phy() function).
> 
> # service network start
> Bringing up loopback interface:                            [  OK  ]
> Bringing up interface eth0:
> Determining IP information for eth0... failed; no link present.  Check cable?
>                                                            [FAILED]

Thanks, your report/dmesg are welcome.

Lars noticed that the link status is not correctly reported and suggested
a few changes. Can you check if the version below works better ?

Single file patch:
http://www.zoreil.com/~romieu/sis190/20050730-2.6.13-rc4-sis190-test.patch

Patch-kit:
http://www.zoreil.com/~romieu/sis190/20050730-2.6.13-rc4/patches

Tarball:
http://www.zoreil.com/~romieu/sis190/20050730-2.6.13-rc4.tar.bz2

If it does not pass the network init, can you issue
- ifconfig eth0 blah, blah by hand
- mii-tool -vvv eth0

I'll send the whole serie of patches to netdev/akpm.

Jeff, do you want that I publish it in some git repo as well ?

--
Ueimor
