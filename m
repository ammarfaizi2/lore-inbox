Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133036AbRAKXpB>; Thu, 11 Jan 2001 18:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132710AbRAKXoo>; Thu, 11 Jan 2001 18:44:44 -0500
Received: from jalon.able.es ([212.97.163.2]:24060 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131017AbRAKXo1>;
	Thu, 11 Jan 2001 18:44:27 -0500
Date: Fri, 12 Jan 2001 00:44:19 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: gregg_99@mailcity.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot compile my kernel due to unpredictible situations:
Message-ID: <20010112004419.A751@werewolf.able.es>
In-Reply-To: <HKPKHOJMBOBKGAAA@mailcity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <HKPKHOJMBOBKGAAA@mailcity.com>; from gregg_99@lycos.com on Fri, Jan 12, 2001 at 00:30:47 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.12 Gregg Lloyd wrote:
> the right 2.4 kernel?? (Kernel howto talks about going to /usr/src/linux and
> start compiling..but current /usr/src/linux is a link to my current 2.2.5
> kernel !!!)
> 
So you have just wrote kernel2.4 OVER your kernel2.2.

Kernel tarballs always untar and give a directory named 'linux'. So suppose
you have a setup like:
ls /usr/src:
linux -> linux-2.2.5
linux-2.2.5

If you untar linux-2.4.0.tar.gz in /usr/src, it writes over 'linux' that points
to you 2.2.5.
What I usually do is
rm -f linux (is just a link)
gtar zxf linux-2.4.0.tar.gz (gives a new REAL directory named 'linux')
mv linux linux-2.4.0
ln -s linux-2.4.0 linux

I don't know why kernels are not tarred as linux-X.X.X, but there will be
a reason, I suppose... (that will ease very much everyone's life).

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.0-ac5 #1 SMP Wed Jan 10 23:36:11 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
