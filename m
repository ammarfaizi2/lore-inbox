Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274255AbRJQCts>; Tue, 16 Oct 2001 22:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274248AbRJQCtj>; Tue, 16 Oct 2001 22:49:39 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:51753 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274298AbRJQCtV>; Tue, 16 Oct 2001 22:49:21 -0400
From: "Steven A. DuChene" <sduchene@mindspring.com>
Date: Tue, 16 Oct 2001 22:48:45 -0400
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org, stelian.pop@fr.alcove.com,
        ion@cs.columbia.edu, sduchene@mindspring.com, jurgen@botz.org
Subject: Re: [PATCH] PnP BIOS -- bugfix; update devlist on setpnp
Message-ID: <20011016224845.C1225@lapsony.mydomain.here>
In-Reply-To: <1002987648.764.23.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
In-Reply-To: <1002987648.764.23.camel@thanatos>; from jdthood@mail.com on Sat, Oct 13, 2001 at 11:40:10AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas:
Just to let you know I still have the same problem with a resource conflict
between the PnPBIOS code and the i2c/lm_sensors stuff at 1040 with this
latest patch. Again, this is on a Intel Lancewood (L440GX) motherboard.
I also have a system with a Intel STL2 motherboard (successor to the
Lancewood) so I will test that under the same conditions later tonight.

modprobe i2c-piix4
/lib/modules/2.4.10-ac12/kernel/drivers/i2c/i2c-piix4.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.10-ac12/kernel/drivers/i2c/i2c-piix4.o: insmod /lib/modules/2.4.10-ac12/kernel/drivers/i2c/i2c-piix4.o failed
/lib/modules/2.4.10-ac12/kernel/drivers/i2c/i2c-piix4.o: insmod i2c-piix4 failed


dmesg

.
.
.
i2c-piix4.o version 2.6.1 (20010830)
i2c-piix4.o: Found PIIX4 device
i2c-piix4.o: SMB region 0x1040 already in use!
i2c-piix4.o: Device not detected, module not inserted.


cat /proc/ioports
.
.
.
0c00-0c3f : Intel Corporation 82371AB PIIX4 ACPI
  0c00-0c3f : PnPBIOS PNP0c02
0ca0-0ca3 : PnPBIOS PNP0c02
0cb8-0cbf : PnPBIOS PNP0c02
0cf8-0cff : PCI conf1
1000-103f : PnPBIOS PNP0c02
1040-105f : Intel Corporation 82371AB PIIX4 ACPI
  1040-104f : PnPBIOS PNP0c02
.
.
.

-- 
Steven A. DuChene	sad@ale.org
			linux-clusters@mindspring.com
			sduchene@mindspring.com

	http://www.mindspring.com/~sduchene/
