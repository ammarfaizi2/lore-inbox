Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263030AbVCDQeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbVCDQeV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 11:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVCDQcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 11:32:51 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:60472 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262918AbVCDQc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 11:32:27 -0500
Message-ID: <42288E3E.5090208@suse.com>
Date: Fri, 04 Mar 2005 11:35:10 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] openfirmware: adds sysfs nodes for openfirmware	devices
References: <20050301211824.GC16465@locomotive.unixthugs.org> <1109806334.5611.121.camel@gaston> <42275536.8060507@suse.com> <20050303202319.GA30183@suse.de> <42277ED8.6050500@suse.com> <20050304110215.GC14408@suse.de>
In-Reply-To: <20050304110215.GC14408@suse.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Olaf Hering wrote:
>  On Thu, Mar 03, Jeff Mahoney wrote:
> 
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Olaf Hering wrote:
>>
>>> On Thu, Mar 03, Jeff Mahoney wrote:
>>>
>>>
>>>
>>>>Is whitespace (in any form) allowed in the compatible value?
>>>
>>>
>>>Yes, whitespace is used at least in the toplevel compatible file, like
>>>'Power Macintosh' in some Pismo models.
>>>
>>
>>Oh well, it was wishful thinking anyway. ;)
> 
> 
> The same thing needs to be solved for vio devices, the properties can
> contain spaces. depmod and modprobe have to deal with it to generate a
> valid module.alias file.

The solution I ended up going with was the original CRLF suggestion, and
then I pass around a group of environment vars in userspace rather than
a single line. This works as before, but works with commas and isn't as
ugly as I had thought it might be.

As far as the modules.aliases file goes, I'm not sure what our options
are there. Is the only requirement that the aliases be consistent in the
kernel and in userspace? Since aliases for OF devices haven't previously
existed, I defined the format. Is there any reason I couldn't define the
format such that whitepsace is replaced by underscores, thus eliminating
this issue?

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCKI4+LPWxlyuTD7IRAvNOAJ0aopD1JcpUpoAMeuI1EVSBVbICCQCgmHVN
QKswIpQ//5SxjnXIk02PBts=
=K/kB
-----END PGP SIGNATURE-----
