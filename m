Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289402AbSAJLWx>; Thu, 10 Jan 2002 06:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289403AbSAJLWn>; Thu, 10 Jan 2002 06:22:43 -0500
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:38820
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S289401AbSAJLWa>; Thu, 10 Jan 2002 06:22:30 -0500
Message-ID: <3C3D7966.3080605@debian.org>
Date: Thu, 10 Jan 2002 12:22:14 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Kirkwood <matthew@hairy.beasts.org>
CC: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
In-Reply-To: <fa.d7rnnnv.1l1gnri@ifi.uio.no> <fa.p5gg3pv.1iiscrg@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Kirkwood wrote:

> On Wed, 9 Jan 2002, Eric S. Raymond wrote:
> 
>>The autoconfigurator is *not* mean to be run at boot time, or as root.
>>
> 
> Under normal circumstances.
> 


???? Could you tell me about an 'anormal' circumstance that
need autoconfigurator at boot time ?


> 
>>It is intended to be run by ordinary users, after system boot time.
>>This is so they can configure and experimentally build kernels without
>>incurring the "oops..." risks of going root.
>>
> 
> Then ship it in a separate package with initscripts.  Either
> CML2 is well enough designed that the autoconfigurator will
> not need to change as the kernel does, or all your
> overengineering was for nought.


No problem. Autoconfigurator can live without important files.
I.e. no /proc/bus/{pci,usb}, autoconfigurator will ignore such
detections. (it would not say: no PCI cards, but unfortunatelly
it will find only few PCI cards (via /proc/{devices,misc}, if you
have luke)).

BTW: IMHO I can complete the detection, also with ISA cards,
before Eric will start including dmi.
How to handle a driver db with dmi strings and kernel configurations?
It seems to me to complex to try it. We need every possible machine
to extract data.

	giacomo

