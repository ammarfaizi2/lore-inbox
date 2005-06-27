Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVF1ROY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVF1ROY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 13:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVF1RM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 13:12:59 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:47486 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262163AbVF1RCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 13:02:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=nd0CuhvkCaee0BiBO7UcNLLSmZ+QBR68bfHaUIe8Mp+2MqbhMyBPq2YorPmSM/XWLizYxbkLn8cfBzp2h81hzqNDNxMJ1+uce3om2RujnYVp6rKy9e7YX3ghwMytjsyi+dwT7tKaA7byhnZbE6uTn71hQ+kze1AyMNLVlhLg8TI=
Message-ID: <42C05900.5050202@gmail.com>
Date: Mon, 27 Jun 2005 19:52:32 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Jeff Sipek <jeffpc@optonline.net>
CC: Andi Kleen <ak@suse.de>, Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH v2][TRIVIAL] Allocate kprobe_table at runtime
References: <20050626183049.GA22898@optonline.net.suse.lists.linux.kernel> <20050627055150.GA10659@in.ibm.com.suse.lists.linux.kernel> <p737jggwcln.fsf@verdi.suse.de> <20050627130139.GD22311@optonline.net>
In-Reply-To: <20050627130139.GD22311@optonline.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> I agree that BSS is good enough.

Alternatively, you can implement dynamic allocation of each element of
kprobe_table in register_kprobe function. You will be able to free them by
calling unregister_kprobe function later on.

Regards,
- --
					Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQsBY/8zkDT3RfMB6AQJBGQf+PUMdOIpAfq4Q5lI77P7uSx1vdq2905Dp
UwowzJpBLhQoZWI94xmhp7zx2unu5IqKBoXl62sjqOLgT9/K417ReEKFKfN3SSex
shtulBOFxHfimNZX1mYhtmgJxKMU3jb3jyjXQg4oufL15Khl5PqkIxWewcVGB8LB
bciH1242moxl7jKmEJXqm8IU4ZezOpfRoBYnvaxVrr1zL/zQzUgISgBfb2GkYpSP
ErXg+w8ggUJ/TDlkZyGjT1OmjhLmb1ekYxzUE/K+dYnP5GGC/sGx5t/YgLxiKXjL
nfNM7oF8qP43eArFmbQlUpMAXpkCWOGr7v5Ifcq8hJRfo99B9GL5uA==
=fBGJ
-----END PGP SIGNATURE-----

