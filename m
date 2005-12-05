Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVLESPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVLESPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVLESPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:15:24 -0500
Received: from javad.com ([216.122.176.236]:7691 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S932493AbVLESPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:15:23 -0500
From: Sergei Organov <osv@javad.com>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: SATA ICH6M problems on Sharp M4000
References: <200511221013.04798.marekw1977> <87u0dri996.fsf@javad.com>
	<20051205202228.13232c10.vsu@altlinux.ru>
Date: Mon, 05 Dec 2005 21:15:09 +0300
In-Reply-To: <20051205202228.13232c10.vsu@altlinux.ru> (Sergey Vlasov's
	message of "Mon, 5 Dec 2005 20:22:28 +0300")
Message-ID: <874q5nfm1e.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.17 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov <vsu@altlinux.ru> writes:
> On Fri, 02 Dec 2005 22:33:57 +0300 Sergei Organov wrote:
>
>> Sorry, but provided ata_piix has ignored the optical drive, couldn't
>> corresponding I/O resource be left free so that subsequently loaded,
>> say, generic-ide module is able to get over and support the drive?
>> 
>> BTW, loading the modules in reverse order helped on 2.6.13 kernel (that
>> I'm currently using) as generic-ide didn't recognize the hard-drive at
>> all allowing ata_piix to get over it later. With 2.6.14 kernel
>> generic-ide does recognize both hard-drive and optical drive thus
>> preventing ata_piix from managing the hard-drive :(
>
> See http://lkml.org/lkml/2005/10/18/167 and the reply to it :-\

Well, Jef's answer was:

  This is a reasonable point, but the rare person who runs modular IDE on 
  these PATA/SATA combined mode beasts can certainly tell the IDE driver 
  to not probe certain ports.

I can say that the kernel I have problem with is from Debian "testing"
distribution so those "rare person" going to become quite a few in the
near future. Besides, Debian loads ata_piix first, then IDE, so telling
the IDE to ignore certain ports won't help.

Though one can argue that that's yet another distribution problem, I
fail to see a way for a distribution to overcome the problem provided it
doesn't know the exact hardware it will run on. No hope for modularized
kernel to run out of the box on given hardware?

Jeff, is there any hope it will be fixed in the kernel.org sources, or
should I report the problem to Debian instead so that they consider
maintaining their own patch?

> If you want to build IDE as modules and still have support for
> combined mode, you will need the patch below:

Sergey, thanks for the patch, -- now I understand the origin of the
problem and how to avoid it should I consider building the kernel
myself.

-- Sergei.
