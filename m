Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWEZKyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWEZKyX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 06:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWEZKyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 06:54:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:36285 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751393AbWEZKyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 06:54:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=ma+wxA+kQwaM40Spl7OiMdneWZhXlTRMYtaFJSQPXrMjjLV7b8GPnUYvdRsN9qiyq3pTLWPxZSs7kO123LpLmaDuX85qW8nbj0tMYSW48fFWNhcVyQW1anDcQSDhHrmniJS56x+NSa0LvAjj+GrDwVoI8bABK9QDBLQY6rkCdQw=
Message-ID: <4476DE47.7010907@gmail.com>
Date: Fri, 26 May 2006 12:53:36 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       mb@bu3sch.de, st3@riseup.net, linville@tuxdriver.com
Subject: Re: [PATCH 2/3] pci: bcm43xx avoid pci_find_device
References: <20060526001053.D2349C7C58@atrey.karlin.mff.cuni.cz> <44764D4B.6050105@pobox.com> <4476D63E.8090207@gmail.com> <4476D6EC.4060501@pobox.com> <4476D95B.5030601@gmail.com> <4476DA5C.9080602@pobox.com>
In-Reply-To: <4476DA5C.9080602@pobox.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Garzik napsal(a):
> The point is that you don't need to loop over the table,
> pci_match_one_device() does that for you.
The problem is, that there is no such function, I think.
If you take a look at pci_dev_present:
http://sosdg.org/~coywolf/lxr/source/drivers/pci/search.c#L270
They traverse the table in similar way as I do.

pci_match_one_device() just checks (one to one) values without any looping.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEdt5HMsxVwznUen4RAqt8AJ9pzaDey2zn399lrahelv17w8IiDgCguUwa
4xOX7pUX2Au/WBsbJbnNwBE=
=P1cu
-----END PGP SIGNATURE-----
