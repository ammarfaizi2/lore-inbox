Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUIAOC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUIAOC6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 10:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUIAOC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 10:02:57 -0400
Received: from frontend1.messagingengine.com ([66.111.4.30]:15046 "EHLO
	frontend1.messagingengine.com") by vger.kernel.org with ESMTP
	id S266650AbUIAN7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:59:55 -0400
X-Sasl-enc: YClsX/3w2Pn/AT64kxFC9g 1094047193
Date: Wed, 01 Sep 2004 15:59:49 +0200
From: harry_b@mm.st
Reply-To: harry_b@mm.st
To: James Bourne <jbourne@hardrock.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initrd missing TTY
Message-ID: <1B1B394B2B14C4B2DA3856C1@[192.168.1.247]>
In-Reply-To: <Pine.LNX.4.58.0409010749510.6483@rio.clgy.hardrock.org>
References: <D41AD36206E266D4B00EBFCD@[192.168.1.247]>
 <Pine.LNX.4.58.0409010749510.6483@rio.clgy.hardrock.org>
X-Mailer: Mulberry/3.1.6 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

- --On Wednesday, September 01, 2004 07:53:13 -0600 James Bourne 
<jbourne@hardrock.org> wrote:

>> I am not sure where to ask this question but I hope this is the right
>> place.
>>
>> I am trying to setup an encrypted root partition where the key is stored
>> gpg-encrypted on an USB memorystick. So far everything works quite
>> nicely  but I fail to get a TTY working in the initial RAM disk.
>>
>> All I get is gpg complaining:
>> gpg: cannot open '/dev/tty': No such device or address
>>
>> Any idea what's necessary to get a TTY within the RAM disk? Or is there
>> any  other way to pass a passphrase to gpg without displaying it on the
>> screen? (yes, I know about the --no-tty and --passphrase-fd options but
>> when I use  /dev/console the passphrase is visible)
>
> make sure /dev/tty exists on your initrd image.  You can created this by
> mounting your initrd image, changing to the dev directory on that image
> and running mknod -m 644 tty c 5 0.

I have all devices available. Right now I have udev running but I also 
tried a fully populated static /dev directory.

My current tty looks quite normal like
crw-rw-rw- 1 0 0 5, 0 Sep 1 12:10 /dev/tty
and tty1, tty2 have
crw-rw-rw- 1 0 0 4, 1 Sep 1 12:10 /dev/tty1
crw-rw-rw- 1 0 0 4, 2 Sep 1 12:10 /dev/tty2
...

Harry

- --

1024D/40F14012 18F3 736A 4080 303C E61E  2E72 7E05 1F6E 40F1 4012

- -----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GIT/S dx s: a C++ ULS++++$ P+++ L+++$ !E W++ N+ o? K? !w !O !M
V PS+ PE Y? PGP+++ t+ 5-- X+ R+ !tv b++ DI++ D+ G e* h r++ y++
- ------END GEEK CODE BLOCK------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBNdXVfgUfbkDxQBIRApz2AKCfReZz9d7a7XWKXqYTVG25K4pShQCfQ6jT
ndXd09GQGN+yLNp1sizUotM=
=QK72
-----END PGP SIGNATURE-----

