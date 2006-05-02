Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWEBUfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWEBUfr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWEBUfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:35:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:26862 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932241AbWEBUfq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:35:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oNMzsqVkp5zdcwJFQRM7RNj/ilyiz/o1p+9nD7tiCCVybyuf0tU0p8YvipQJTB6pT5k+bwdyPJ66kMZ6bR5Tp5sAfr0R/6UHVzsdziO2GOOSB0fyA+UQfNfZJaj20/YO36cy+xAn+bWRrBoaWcwvblyUSnxd5Cl4Sg6A9dvKuF4=
Message-ID: <60f2b0dc0605021335k6e84156ejd0945c6d416ef2d1@mail.gmail.com>
Date: Tue, 2 May 2006 22:35:43 +0200
From: "Olivier Fourdan" <fourdan@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.17-rc3-mm1: x86_64 option "apicpmtimer" doesn't work anymore?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Some time arround 2.6.16, Andi added the option "apicpmtimer" (only on
x86_64) that "do APIC timer calibration using the pmtimer".

It seems that 2.6.17-rc3-mm1 fails to boot with that option. The boot
process just stalls. There is no panic nor error message (AFAICT), it
just...stalls. Unfortunately, I really need that "apicpmtimer" option
because the PIT is very broken on my laptop.

With 2.6.16 and 2.6.17-rc3, the boot also stalled with "apicpmtimer",
but pressing the power button again resumed the boot, but not anymore
with 2.6.17-rc3-mm1, it just stays stuck.

I've seen there are some issues with merging the clocksource in
2.6.17-rc3-mm1, but I'm not sure "apicpmtimer" and acpi_pm clocksource
are similar, are they?

Anyway, I applied the patch mentionned in the "clocksource" thread and
that doesn't help.

Thanks in advance,
Cheers,
Olivier.
