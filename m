Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261301AbRE2SRu>; Tue, 29 May 2001 14:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbRE2SRl>; Tue, 29 May 2001 14:17:41 -0400
Received: from cliff.mcs.anl.gov ([140.221.9.17]:16258 "EHLO mcs.anl.gov")
	by vger.kernel.org with ESMTP id <S261301AbRE2SRf>;
	Tue, 29 May 2001 14:17:35 -0400
To: linux-kernel@vger.kernel.org
Subject: serial console problems under 2.4.4/5
From: "Narayan Desai" <desai@mcs.anl.gov>
Date: 29 May 2001 13:17:28 -0500
Message-ID: <yrxofscdnpj.fsf@terra.mcs.anl.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I have started having serial console problems in the last bunch of
kernel releases. I have tried various 2.4.4 and 2.4.5 ac kernels (up
to and including 2.4.5-ac4) and the problem has persisted. The problem
is basically that serial console doesn't recieve. I know that the
hardware works properly, and lilo and other kernels even work fine
from serial console. As far as I can tell, only one direction is
broken, serial receive. (ie, an echo foo > /dev/ttyS0 shows up on
the serial console, but an echo to the serial device on the other end
of the console never shows up)

The serial hardware is detected:
Serial driver version 5.05b (2001-05-03) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled 
ttyS00 at 0x03f8 (irq = 4) is a 16550A 
ttyS01 at 0x02f8 (irq = 3) is a 16550A 

the pertinant parts of .config are:
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
CONFIG_ROCKETPORT=y
# CONFIG_CYCLADES is not set

Has anyone else seen this, or have any ideas what is broken?
thanks...
 -nld
