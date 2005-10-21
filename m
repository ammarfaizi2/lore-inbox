Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbVJURDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbVJURDd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 13:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVJURDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 13:03:33 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:64398 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965031AbVJURDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 13:03:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=S5JbrXOBMGeAWeREWye3paPfa9GOW1NWpArQYunG3pXhtzltfSL4mkHfr7UMsKNbb84VIFCQ9yE01bS1PIf28IgbIq3EASCQfJk+z6m0n+n4cDuXAdQ97ANaRlNH+9Dbfp3tc/BntRyZjym54auP94otelwhSFPzUd7KDHa1GwQ=
Message-ID: <5bdc1c8b0510211003j4e9bf03bhf1ea8e94ffe60153@mail.gmail.com>
Date: Fri, 21 Oct 2005 10:03:29 -0700
From: Mark Knecht <markknecht@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc5-rt3 - `IRQ 8'[798] is being piggy
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6286_22712346.1129914209375"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_6286_22712346.1129914209375
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
   Maybe I'm catching something here? Maybe not - no xruns as of yet,
but I've never seen these messages before. Kernel config attached.

   dmesg has filled up with these messages:

Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=3D0, cpu=3D0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=3D0, cpu=3D0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=3D0, cpu=3D0
Read missed before next interrupt
wow!  That was a 14 millisec bump
`IRQ 8'[798] is being piggy. need_resched=3D0, cpu=3D0
Read missed before next interrupt
wow!  That was a 12 millisec bump
`IRQ 8'[798] is being piggy. need_resched=3D0, cpu=3D0
Read missed before next interrupt
wow!  That was a 17 millisec bump
`IRQ 8'[798] is being piggy. need_resched=3D0, cpu=3D0
Read missed before next interrupt
wow!  That was a 89 millisec bump
lightning ~ #

lightning ~ # cat /proc/interrupts
           CPU0
  0:     928484    IO-APIC-edge  timer
  1:        572    IO-APIC-edge  i8042
  7:          2    IO-APIC-edge  lpptest
  8:     529468    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
  12:      91942    IO-APIC-edge  i8042
  14:         48    IO-APIC-edge  ide0
  50:          2   IO-APIC-level  ehci_hcd:usb1
  58:     534656   IO-APIC-level  hdsp
  66:          2   IO-APIC-level  ohci1394
217:     532660   IO-APIC-level  ohci_hcd:usb2, eth0
225:      24239   IO-APIC-level  libata, NVidia CK804
233:       9083   IO-APIC-level  libata
NMI:        263
LOC:     928256
ERR:          1
MIS:          0
lightning ~ #

Cheers,
Mark

------=_Part_6286_22712346.1129914209375
Content-Type: application/x-bzip2; name=knecht.config-2.6.14-rc5-rt3.bz2
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="knecht.config-2.6.14-rc5-rt3.bz2"

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
------=_Part_6286_22712346.1129914209375--
