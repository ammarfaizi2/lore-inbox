Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756791AbWKSRHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756791AbWKSRHo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 12:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756793AbWKSRHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 12:07:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:32911 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1756791AbWKSRHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 12:07:43 -0500
Message-ID: <45608FC2.5040406@suse.com>
Date: Sun, 19 Nov 2006 12:09:22 -0500
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com,
       sam@ravnborg.org, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: reiserfs NET=n build error
References: <20061118202206.01bdc0e0.randy.dunlap@oracle.com> <200611190650.49282.ak@suse.de>
In-Reply-To: <200611190650.49282.ak@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen wrote:
> On Sunday 19 November 2006 05:22, Randy Dunlap wrote:
>> With CONFIG_NET=n and REISERFS_FS=m (randconfig), kernel build ends with
>>
>> Kernel: arch/x86_64/boot/bzImage is ready  (#15)
>>   Building modules, stage 2.
>>   MODPOST 137 modules
>> WARNING: "csum_partial" [fs/reiserfs/reiserfs.ko] undefined!
>> make[1]: *** [__modpost] Error 1
>> make: *** [modules] Error 2
>>
>> on both 2.6.19-rc6 and 2.6.19-rc6-git2.
>>
>> Looks like arch/x86_64/lib/lib.a is not being linked into the
>> final kernel image for some reason.  lib.a does contain csum_partial.
> 
> iirc Al Viro has been cleaning that up. Essentially reiserfs should
> use its own C copy of the checksum functions. Using csum_partial() is not
> safe because its output varies by architecture.
> 
> I would copy a relatively simple C implementation, like arch/h8300/lib/checksum.c

As long as the h8300 version has the same output as the x86 version.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFYI/BLPWxlyuTD7IRAjveAJ0U+D3PO6h+2z83ZG9ZLay3q5JBFACcDHFQ
hIaiIBCFzfHg9qak9cxUtRo=
=GuqM
-----END PGP SIGNATURE-----
