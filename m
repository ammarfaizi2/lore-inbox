Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbTFDWJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 18:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbTFDWJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 18:09:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:10185 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264201AbTFDWJB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 18:09:01 -0400
Date: Wed, 4 Jun 2003 17:20:51 -0500
From: linas@austin.ibm.com
To: "J.A. Magallon" <jamagallon@able.es>
Cc: lnz@dandelion.com, mike@i-connect.net, eric@andante.org,
       linux-kernel@vger.kernel.org, olh@suse.de, groudier@free.fr,
       axboe@suse.de, acme@conectiva.com.br, linas@linas.org
Subject: Re: Patches for SCSI timeout bug
Message-ID: <20030604172051.A33396@forte.austin.ibm.com>
References: <20030604163415.A41236@forte.austin.ibm.com> <20030604214442.GI4939@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030604214442.GI4939@werewolf.able.es>; from jamagallon@able.es on Wed, Jun 04, 2003 at 11:44:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Wed, Jun 04, 2003 at 11:44:43PM +0200, J.A. Magallon wrote:
> 
> On 06.04, linas@austin.ibm.com wrote:
> > 
> > Hi,
> > 
> > I've got a SCSI timeout bug in kernels 2.4 and 2.5, and several 
> > different patches (appended) that fix it.  I'm not sure which way 
> > of fixing it is best.
> 
> Can you try with this:
> 
> --- linux-2.4.18-18mdk/drivers/scsi/scsi_error.c.scsi-eh-timeout	Thu May 30 16:22:37 2002
> +++ linux-2.4.18-18mdk/drivers/scsi/scsi_error.c	Sun Jun  9 19:18:11 2002
> @@ -1103,6 +1103,8 @@


Sorry, no, its not enough.
Here's the boot log; I'm going to turn on more debug messages in 
next email.

--linas

SCSI subsystem driver Revision: 1.00
PCI: Enabling device 00:0c.0 (0140 -> 0143)
sym53c8xx: at PCI bus 0, device 12, function 0
sym53c8xx: setting PCI_COMMAND_MASTER...(fix-up)
sym53c8xx: 53c875 detected
PCI: Enabling device 00:11.0 (0140 -> 0143)
sym53c8xx: at PCI bus 0, device 17, function 0
sym53c8xx: setting PCI_COMMAND_MASTER...(fix-up)
sym53c8xx: 53c895 detected
sym53c875-0: rev 0x4 on pci bus 0 device 12 function 0 irq 17
sym53c875-0: ID 7, Fast-20, Parity Checking
sym53c875-0: resetting, command processing suspended for 2 seconds
sym53c895-1: rev 0x1 on pci bus 0 device 17 function 0 irq 20
sym53c895-1: ID 7, Fast-40, Parity Checking
sym53c895-1: resetting, command processing suspended for 2 seconds
scsi0 : sym53c8xx-1.7.3c-20010512
scsi1 : sym53c8xx-1.7.3c-20010512
scsi : aborting command due to timeout : pid 8, scsi0, channel 0, id 4, lun 0 I
sym53c8xx_abort: pid=8 serial_number=9 serial_number_at_timeout=9
SCSI host 0 abort (pid 8) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
sym53c8xx_reset: pid=8 reset_flags=2 serial_number=9 serial_number_at_timeout=9
sym53c875-0: resetting, command processing suspended for 2 seconds
SCSI host 0 abort (pid 9) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
sym53c8xx_reset: pid=9 reset_flags=2 serial_number=10 serial_number_at_timeout=0sym53c875-0: resetting, command processing suspended for 2 seconds
SCSI host 0 abort (pid 10) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
sym53c8xx_reset: pid=10 reset_flags=2 serial_number=11 serial_number_at_timeout1sym53c875-0: resetting, command processing suspended for 2 seconds
SCSI host 0 abort (pid 11) timed out - resetting
SCSI bus is being reset for host 0 channel 0.




