Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWHKOoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWHKOoq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 10:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWHKOoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 10:44:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:39097 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750910AbWHKOop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 10:44:45 -0400
Message-ID: <44DC98B5.4000602@suse.com>
Date: Fri, 11 Aug 2006 10:48:21 -0400
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
References: <1155172843.3161.81.camel@localhost.localdomain> <20060809234019.c8a730e3.akpm@osdl.org> <20060810191747.GL20581@ca-server1.us.oracle.com> <20060810194440.GA6845@martell.zuzino.mipt.ru> <44DB945F.5080102@suse.com> <Pine.LNX.4.61.0608110757090.21588@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608110757090.21588@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jan Engelhardt wrote:
>>> Will
>>>
>>> 	printk("%S", sector_t);
>>>
>>> kill at least one kitten?
>> I like the general idea. I think that having to cast every time you want
>> to print a sector number is pretty gross. I had something more like %Su
>> in mind, though.
> 
> What will happen if you run out of %[a-z] ?

Are we really expecting that many global structure members to be
variable width? I only propose adding another option because whenever a
sector is printed, it must be casted to avoid warnings.

Other replies commented on how gcc won't recognize the new option, so
we'd receive warnings anyway. Cleaner code that causes warnings doesn't
sound like a big win after all.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE3Ji1LPWxlyuTD7IRApAEAJ9ApkoyKwmTReZindjJmkuU/0yhbACgk0Uu
zG8eXN3RzU1wKFVrRlr3xO8=
=e6D2
-----END PGP SIGNATURE-----
