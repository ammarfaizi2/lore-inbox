Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310223AbSCPKds>; Sat, 16 Mar 2002 05:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310219AbSCPKdi>; Sat, 16 Mar 2002 05:33:38 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:50416 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S310223AbSCPKda>; Sat, 16 Mar 2002 05:33:30 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0203152339200.31551-100000@penguin.transmeta.com> 
In-Reply-To: <Pine.LNX.4.33.0203152339200.31551-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Anders Gustafsson <andersg@0x63.nu>, arjanv@redhat.com,
        linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] devexit fixes in i82092.c 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Mar 2002 10:32:48 +0000
Message-ID: <31288.1016274768@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  Ideally we should, yes. Although if we really turn off power, it
> doesn't  much matter. 

But we might just be rebooting, not turning off power. And in that case we 
may want to ensure devices are returned to a sane state. Like ensuring that 
the CPU startup vector is pointing at a flash chip which is in _read_ mode, 
not returning status words.

Yes, it happens. I was pondering a reboot notifier but didn't like that much
so was ignoring the problem for now.

--
dwmw2


