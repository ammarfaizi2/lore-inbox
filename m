Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268405AbUI2NPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268405AbUI2NPB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268407AbUI2NPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:15:00 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:4799 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S268405AbUI2NOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:14:05 -0400
Message-ID: <415AB516.80108@logix.cz>
Date: Wed, 29 Sep 2004 15:13:58 +0200
From: Michal Ludvig <michal@logix.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: cs, cz, en
MIME-Version: 1.0
To: Andreas Happe <andreashappe@flatline.ath.cx>
Cc: James Morris <jmorris@redhat.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
References: <20040831175449.GA2946@final-judgement.ath.cx>	<Xine.LNX.4.44.0409010043020.30561-100000@thoron.boston.redhat.com>	<20040901082819.GA2489@final-judgement.ath.cx>	<Pine.LNX.4.53.0409061847000.25698@maxipes.logix.cz>	<20040907143509.GA30920@old-fsckful.ath.cx>	<Pine.LNX.4.53.0409071659070.19015@maxipes.logix.cz>	<20040910105502.GA4663@final-judgement.ath.cx>	<20040927084149.GA3625@final-judgement.ath.cx>	<Pine.LNX.4.53.0409271046280.12238@maxipes.logix.cz> <20040928123426.GA21069@final-judgement.ath.cx>
In-Reply-To: <20040928123426.GA21069@final-judgement.ath.cx>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andreas Happe told me that:
> Michal Ludvig <michal@logix.cz> [040927 11:32]:
> 
>> If I'd finally have two or more modules for the same algorithm loaded,
>> how
>> should the /sys subtree look like?
> 
> good one.
> 
> If there are lots of different implementation for a given algorithm it
> could be worthwhile to create a algorithm and a implementation -
> directory e.g.
> 
> ls /sysfs/class/crypto/implementations would list:
> aes-i586 aes-c4 md5 sha1 sha256-c4
> 
> and: ls /sysfs/class/crypto/algorithms
> aes
> 
> with ls /sysfs/class/crypto/algorithms/aes
> name type implementations
> 
> where implementations is a directory with links to the given
> implementations in /sysfs/class/crypto/implementations.
> 
> Seems like a lot of work if there are only few implementations (like aes
> and aes-i586).

Once we have a support for hardware cryptocards it will be usefull. I'm
already having the VIA PadLock patch that adds yet another AES
implementation. For VIA C7 it will also support SHA (one module, two
algorithms? why not ;-)

IMHO it is worth having it done "right and expandable" since the
beginning (changing the /sys tree once it goes mainline will be harder).

Michal Ludvig
- --
* A mouse is a device used to point at the xterm you want to type in.
* Personal homepage - http://www.logix.cz/michal
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBWrUUDDolCcRbIhgRAqU7AKCCKEUplTD8PJldxT0yodC1M52UjQCg2DSx
Im6Amy3cGI+UhUqo4s/4IVk=
=fqyy
-----END PGP SIGNATURE-----
