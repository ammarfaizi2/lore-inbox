Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTLEMdL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 07:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTLEMdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 07:33:11 -0500
Received: from pop.gmx.net ([213.165.64.20]:57324 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263971AbTLEMdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 07:33:08 -0500
X-Authenticated: #4512188
Message-ID: <3FD07B01.8030804@gmx.de>
Date: Fri, 05 Dec 2003 13:33:05 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Bob <recbo@nishanet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11) - IRQ
 flood related ?
References: <3FCF25F2.6060008@netzentry.com>	 <1070551149.4063.8.camel@athlonxp.bradney.info>	 <20031204163243.GA10471@forming>	 <frodoid.frodo.87vfow33zm.fsf@usenet.frodoid.org>	 <20031204175548.GB10471@forming> <20031204200208.GA4167@localnet>	 <20031204230528.GA189@tesore.local>  <3FCFBFC3.5070403@gmx.de> <1070580108.4100.8.camel@athlonxp.bradney.info> <3FD01BE0.5030807@nishanet.com>
In-Reply-To: <3FD01BE0.5030807@nishanet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob wrote:
> Do you have onboard ethernet enabled with nforce2
> mboard? I am fine with pre-emptive kernel but have
> to disable onboard ethernet in cmos setup or I see
> "Disabling IRQ7" and problems develop.


No, It is enabled in bios, but in my test run i just didn't compile the 
forcedeth driver. So the irq 7 didn't showed up. Eben with my "normal" 
kernel the th0 interface it mapped to irq 10:

            CPU0
   0:    1634197          XT-PIC  timer
   1:       2653          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:       1620          XT-PIC  Skystar2, ohci_hcd, NVidia nForce2
   8:          3          XT-PIC  rtc
   9:          0          XT-PIC  acpi
  10:       9412          XT-PIC  eth0
  11:     171083          XT-PIC  libata, ohci_hcd, nvidia
  12:     110080          XT-PIC  i8042
  14:         10          XT-PIC  ide0
  15:         15          XT-PIC  ide1
NMI:          0
ERR:          2

