Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVJYMCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVJYMCn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 08:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVJYMCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 08:02:43 -0400
Received: from qproxy.gmail.com ([72.14.204.203]:62813 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932084AbVJYMCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 08:02:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=WS4N+9702hRMZ8w19fF6bF6/VyY8YPkKGbwdQY7gnRdc/w3IE3yvJ6+zZWPBgv5CnwZ4Z33WrzBnGWUjBu/FGwa+rXwlNZwlahgNGnZAs3oovBu8r/h66FS/W8YJOrgBb3o1i+UzdQddFSilP369nTtPIlHuvZBPIJ8yV+0hfwY=
Message-ID: <435E1F36.2030108@gmail.com>
Date: Tue, 25 Oct 2005 14:04:06 +0200
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20051014 Thunderbird/1.0.7 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: jonathan@jonmasters.org, jonmasters@gmail.com,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: /proc/kcore size incorrect ?
References: <20051023235806.1a4df9ab@werewolf.able.es>	<35fb2e590510231613u492d24c6k4d65ff3ac5ffcee6@mail.gmail.com> <20051024015710.29a02e63@werewolf.able.es>
In-Reply-To: <20051024015710.29a02e63@werewolf.able.es>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=D6F42CA5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

J.A. Magallon wrote:
> I expected /proc/kcore to give the size of your installed memory, with
> the reserved BIOS areas just not accesible, but it looks like it already
> has them discounted, so gives 1022 Mb.
> 
> It looks really silly to have a motd say "wellcome to this box, it has
> 2 xeons and 1022 Mb of RAM".

I don't know why, but 'du' seems to be doing a better job.

chaosite@kaitou ~ $ du /proc/kcore --block-size=1M
1024	/proc/kcore
chaosite@kaitou ~ $ echo $(($(stat -c %s /proc/kcore) / 1024 / 1024))
1023

- --
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDXh82A7Qvptb0LKURApoUAKCVpGY9BlyD2SwN1aPy566ptf5DGwCdExco
emsyr109/L8ls6Czh7mv45Q=
=jRrP
-----END PGP SIGNATURE-----
