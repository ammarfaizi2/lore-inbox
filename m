Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289571AbSAON31>; Tue, 15 Jan 2002 08:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289573AbSAON3Q>; Tue, 15 Jan 2002 08:29:16 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:3833 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S289571AbSAON3A>; Tue, 15 Jan 2002 08:29:00 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020114165909.A20808@thyrsus.com> 
In-Reply-To: <20020114165909.A20808@thyrsus.com> 
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Jan 2002 13:28:58 +0000
Message-ID: <8381.1011101338@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  If Penelope learns from the README file that all *she* has to do is
> type "configure; make" to build a kernel that supports her hardware,
> she can apply that MEMS card patch and build with confidence that the
> effort is unlikely to turn into an infinite time sink.

> Autoconfigure saves the day again.  That guy in the penguin T-shirt
> might even be impressed...

Bzzt. The PCMCIA card in question wasn't plugged in at the time so didn't 
get enabled, and autoconfigure didn't realise that the software for it 
actually needed CONFIG_NETLINK_DEV even though it wasn't in use at the time.

The sensible all-modules-under-the-sun vendor kernel had netlink_dev 
available though, just in case. But when she calls the support person who's 
responsible for the pre-installed Linux on her workstation and she
admits that she compiled her own kernel, she gets told to go away.

Pity the people who wrote the driver didn't use the saner approach:
	make -C /lib/modules/`uname -r`/kernel SUBDIRS=`pwd` modules

--
dwmw2


