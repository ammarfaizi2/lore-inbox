Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWGLRB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWGLRB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWGLRB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:01:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:13499 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751464AbWGLRB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:01:57 -0400
Message-ID: <44B52B40.3020704@suse.com>
Date: Wed, 12 Jul 2006 13:02:56 -0400
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
References: <44B52674.8060802@suse.com> <200607121857.45988.dada1@cosmosbay.com>
In-Reply-To: <200607121857.45988.dada1@cosmosbay.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eric Dumazet wrote:
> On Wednesday 12 July 2006 18:42, Jeff Mahoney wrote:
>>  On systems with block devices containing slashes (virtual dasd, cciss,
>>  etc), reiserfs will fail to initialize /proc/fs/reiserfs/<dev> due to
>>  it being interpreted as a subdirectory. The generic block device code
>>  changes the / to ! for use in the sysfs tree. This patch uses that
>>  convention.
>>
>>  Tested by making dm devices use dm/<number> rather than dm-<number>
> 
> Your patch handles at most one slash. But the description mentions 'slashes' 
> (ie several slashes)
> 
>> +	if (s)
>> +		*s = '!';
> 
> Maybe you need a loop

I'd prefer to correct the grammar rather than the patch. This patch
simply duplicates the logic in make_block_name().

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEtStALPWxlyuTD7IRAgl0AJ9Q25r0SIZpIZrX/m6ld69OLwvoxQCfdRj/
XIT1LYuQThoypHAx7ud96h8=
=0ZdG
-----END PGP SIGNATURE-----
