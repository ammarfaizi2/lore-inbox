Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbVLESUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVLESUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVLESUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:20:36 -0500
Received: from mail.dvmed.net ([216.237.124.58]:53899 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932495AbVLESUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:20:35 -0500
Message-ID: <439484EC.5080406@pobox.com>
Date: Mon, 05 Dec 2005 13:20:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergei Organov <osv@javad.com>
CC: Sergey Vlasov <vsu@altlinux.ru>, linux-kernel@vger.kernel.org
Subject: Re: SATA ICH6M problems on Sharp M4000
References: <200511221013.04798.marekw1977> <87u0dri996.fsf@javad.com>	<20051205202228.13232c10.vsu@altlinux.ru> <874q5nfm1e.fsf@javad.com>
In-Reply-To: <874q5nfm1e.fsf@javad.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Sergei Organov wrote: > Sergey Vlasov <vsu@altlinux.ru>
	writes: > >>On Fri, 02 Dec 2005 22:33:57 +0300 Sergei Organov wrote: >>
	>> >>>Sorry, but provided ata_piix has ignored the optical drive,
	couldn't >>>corresponding I/O resource be left free so that
	subsequently loaded, >>>say, generic-ide module is able to get over and
	support the drive? >>> >>>BTW, loading the modules in reverse order
	helped on 2.6.13 kernel (that >>>I'm currently using) as generic-ide
	didn't recognize the hard-drive at >>>all allowing ata_piix to get over
	it later. With 2.6.14 kernel >>>generic-ide does recognize both
	hard-drive and optical drive thus >>>preventing ata_piix from managing
	the hard-drive :( >> >>See http://lkml.org/lkml/2005/10/18/167 and the
	reply to it :-\ > > > Well, Jef's answer was: > > This is a reasonable
	point, but the rare person who runs modular IDE on > these PATA/SATA
	combined mode beasts can certainly tell the IDE driver > to not probe
	certain ports. > > I can say that the kernel I have problem with is
	from Debian "testing" > distribution so those "rare person" going to
	become quite a few in the > near future. Besides, Debian loads ata_piix
	first, then IDE, so telling > the IDE to ignore certain ports won't
	help. > > Though one can argue that that's yet another distribution
	problem, I > fail to see a way for a distribution to overcome the
	problem provided it > doesn't know the exact hardware it will run on.
	No hope for modularized > kernel to run out of the box on given
	hardware? > > Jeff, is there any hope it will be fixed in the
	kernel.org sources, or > should I report the problem to Debian instead
	so that they consider > maintaining their own patch? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergei Organov wrote:
> Sergey Vlasov <vsu@altlinux.ru> writes:
> 
>>On Fri, 02 Dec 2005 22:33:57 +0300 Sergei Organov wrote:
>>
>>
>>>Sorry, but provided ata_piix has ignored the optical drive, couldn't
>>>corresponding I/O resource be left free so that subsequently loaded,
>>>say, generic-ide module is able to get over and support the drive?
>>>
>>>BTW, loading the modules in reverse order helped on 2.6.13 kernel (that
>>>I'm currently using) as generic-ide didn't recognize the hard-drive at
>>>all allowing ata_piix to get over it later. With 2.6.14 kernel
>>>generic-ide does recognize both hard-drive and optical drive thus
>>>preventing ata_piix from managing the hard-drive :(
>>
>>See http://lkml.org/lkml/2005/10/18/167 and the reply to it :-\
> 
> 
> Well, Jef's answer was:
> 
>   This is a reasonable point, but the rare person who runs modular IDE on 
>   these PATA/SATA combined mode beasts can certainly tell the IDE driver 
>   to not probe certain ports.
> 
> I can say that the kernel I have problem with is from Debian "testing"
> distribution so those "rare person" going to become quite a few in the
> near future. Besides, Debian loads ata_piix first, then IDE, so telling
> the IDE to ignore certain ports won't help.
> 
> Though one can argue that that's yet another distribution problem, I
> fail to see a way for a distribution to overcome the problem provided it
> doesn't know the exact hardware it will run on. No hope for modularized
> kernel to run out of the box on given hardware?
> 
> Jeff, is there any hope it will be fixed in the kernel.org sources, or
> should I report the problem to Debian instead so that they consider
> maintaining their own patch?

Debian doesn't need to maintain a patch, they should load modules in the 
proper order.

	Jeff



