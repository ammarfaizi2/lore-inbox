Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVINULc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVINULc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVINULc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:11:32 -0400
Received: from smtp04.auna.com ([62.81.186.14]:10940 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S932179AbVINULb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:11:31 -0400
Date: Wed, 14 Sep 2005 20:11:27 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCH] i386: fix stack alignment for signal handlers
To: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
References: <43273CB3.7090200@oberhumer.com>
	<Pine.LNX.4.58.0509131542510.26803@g5.osdl.org> <4327611D.7@oberhumer.com>
In-Reply-To: <4327611D.7@oberhumer.com> (from markus@oberhumer.com on Wed
	Sep 14 01:30:37 2005)
X-Mailer: Balsa 2.3.4
Message-Id: <1126728687l.6759l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.213.114] Login:jamagallon@able.es Fecha:Wed, 14 Sep 2005 22:11:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.14, Markus F.X.J. Oberhumer wrote:
...
> 
> #include <stdio.h>
> #include <signal.h>
> #include <unistd.h>
> #include <assert.h>
> 
> typedef struct { double x,y; } Aligned16 __attribute__((__aligned__(16)));
> 
> void *saved_esp;
> void handler(int unused) {
>          Aligned16 a;
>          assert(__alignof(a) >= 16),

errr...   assert(__alignof(a) < 16), ???


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.13-jam4 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))


