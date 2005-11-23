Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbVKWEJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbVKWEJR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 23:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbVKWEJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 23:09:16 -0500
Received: from bigip-smtp1.dyxnet.com ([202.66.146.141]:26349 "EHLO
	bigip-smtp1.dyxnet.com") by vger.kernel.org with ESMTP
	id S932507AbVKWEJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 23:09:16 -0500
Message-ID: <4383EB68.1040604@thizgroup.com>
Date: Wed, 23 Nov 2005 12:09:12 +0800
From: Zhang Le <robert@thizgroup.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051028)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: liyu <liyu@ccoss.com.cn>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Question] I doublt on spin_lock again.
References: <4383CE48.60007@ccoss.com.cn> <4383D92A.9070409@thizgroup.com> <4383DA6B.400@ccoss.com.cn>
In-Reply-To: <4383DA6B.400@ccoss.com.cn>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

liyu wrote:

| 1.  I know local_irq_save() in task_rq_lock(), but it only save
| FLAGS register to one unsigned long variable, but not disable
| maskable interrupt.

#define local_irq_save(x)   __asm__ __volatile__("pushfl ; popl %0 ;
cli":"=g" (x): /* no
~ input */ :"memory")

- --
Zhang Le, Robert
Linux Engineer/Trainer

ThizLinux Laboratory Limited
Address: Unit 1004, 10/F, Tower B,
Hunghom Commercial Centre, 37 Ma Tau Wai Road,
To Kwa Wan, Kowloon, Hong Kong
Telephone: (852) 2735 2725
Mobile:(852) 9845 4336
Fax: (852) 2111 0702
URL: http://www.thizgroup.com
Public key: gpg --keyserver pgp.mit.edu --recv-keys 1E4E2973

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDg+tnvFHICB5OKXMRAq+UAJ9svPra7vq5Q60T89B5mA+KJMFf6wCfXPGS
Lv/nGwQkHaXUpKYfYx+dxxg=
=xjKN
-----END PGP SIGNATURE-----

