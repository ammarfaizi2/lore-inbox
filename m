Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVHFMSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVHFMSL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 08:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVHFMSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 08:18:11 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:60387 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261633AbVHFMSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 08:18:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=WTJDMys4Z8Kk9bib2PdYAQGfSu9DQykVbWLlX4oXqkY1kqbMFs0GboicqvNO3xkG4aVt9vCAYlkTco/Rt7DVzBr6tIAfFljyWcXBmanVrZBxYNe0HTKCIEZ6YEh0ltemHG9i+6u9iqhaL1pqoIpKR6WQNBScXgcthP+eN+G4G9c=
Message-ID: <42F4C6E8.1050605@gmail.com>
Date: Sat, 06 Aug 2005 14:19:20 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: rdunlap@osdl.org, fastboot@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kexec and frame buffer
References: <42F219B3.6090502@gmail.com> <m17jf1zgnz.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m17jf1zgnz.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eric W. Biederman ha scritto:
> So without doing passing --real-mode the vga= parameter currently
> cannot work.  The vga= parameter is processed by vga.S which
> make BIOS calls and we bypass all of the BIOS calls.
Actually that file is video.S

> So you can try with the --real-mode option and you have
> a chance of the code working.  Or you can figure out which
> information video.S passes to the kernel figure out how
> to get that same information out of a running kernel
> and then /sbin/kexec can be tweaked to pass the current
> video mode.  Changing frame buffer modes shouldn't work
> but you should at least be able to preserve the existing
> ones.
I tried to pass --real-mode flag to kexec but my virtual machine doesn't like
it. When I launch kexec -e, it tells me: "A strange behaviour occourred which
crashed virtual machine". I'll dig source code ASAP to figure out this matter.
Meanwhile I'm going to follow your advice to inspect video.S in order to track
down something useful.

Regards,
- --
					Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQvTG5czkDT3RfMB6AQJY8Qf9HucRMCCAvta/pAs1CakqwJs5bZo4uJUu
3tat7+24I57mDmj+2IGe7qLO9W9ctCyVJStHTMCpjYq0qF7TA9VZSsU3ip1h9/IG
HnCzozUGpd3yrNsrs3v0fvinQ1z2UtrOY8lxCUISchI3Ho43KnPDoAV2mfT+eEcP
pN/lUz6Z/Jb0YbNS9Z352bqs+JtuxHzX1pVD4uH4X+Dkua3kAde5C0bwP9K+O15A
//qlXb4AJErv6I5+Q/RxCDAn4TtVJCcdoA9Sp84ZH8jnxiYkg2coijvwFHLLvPD/
bK49QyD5QHmsVC3x/pIefd3qPEOphbNPE7AlN86X8B4i8lI6jr2x3g==
=YhUC
-----END PGP SIGNATURE-----
