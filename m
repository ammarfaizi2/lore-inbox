Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWC0OzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWC0OzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 09:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWC0OzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 09:55:08 -0500
Received: from web30606.mail.mud.yahoo.com ([68.142.200.129]:6810 "HELO
	web30606.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751040AbWC0OzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 09:55:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=3LzS3Wl9l/9teFu6Ypn6ld0x1rGJZ7MreeYwRyqACiXCCizfTo0ctSD+IoGfgZJrFJgVGRBwaPobWlxOue+NT4E7bgCqVnHSue0ogrsKZY4kAFVXp+U/QsJUoaxTOyoqzmrOc2im6u5dhDIZP2pQ3is2ESUKRgY0w/bAFW1QPBI=  ;
Message-ID: <20060327145501.34766.qmail@web30606.mail.mud.yahoo.com>
Date: Mon, 27 Mar 2006 16:55:01 +0200 (CEST)
From: zine el abidine Hamid <zine46@yahoo.fr>
Subject: Detecting I/O error and Halting System
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I have I/O error which occurs on servers based on a
VIA VT82C686 chipset and I have to prevent or stop the
error. I spent a lot time for searching solutions to
stop the error but I don't found anything, So I want
to write a module which will surveil the HDD and 
stops the system after sending a mail.

I read a lot of documents about kernel and writting
modules but I don't know how to start...? Help,
please.

I'm not closed to others solutions (like smartd, or
writting classical programms)

Best regards.

Zine

PS : this are errors du to VIA chipset; if anyone
knows wath appens...?


 Feb 12 04:46:03 porte_de_clignancourt_nds_b kernel:
hda: timeout waiting for DMA
Feb 12 04:46:06 alesia_nds_b ucd-snmp[812]: Connection
from 104.25.3.11
Feb 12 04:46:23 porte_de_clignancourt_nds_b kernel:
ide_dmaproc: chipset supported ide_dma_timeout func
only: 14
Feb 12 04:46:23 porte_de_clignancourt_nds_b kernel:
hda: status timeout: status=0xd0 { Busy }      adapter
disque annonce un status busy du DMA
Feb 12 04:46:23 porte_de_clignancourt_nds_b kernel:
hda: drive not ready for command
Feb 12 04:46:23 porte_de_clignancourt_nds_b
ucd-snmp[813]: Connection from 104.1.3.11
Feb 12 04:46:23 porte_de_clignancourt_nds_b
ucd-snmp[813]: Connection from 104.1.3.11
Feb 12 04:46:23 porte_de_clignancourt_nds_b last
message repeated 3 times
Feb 12 04:46:23 porte_de_clignancourt_nds_b kernel:
ide0: reset: success             
Feb 12 10:22:38 porte_de_clignancourt_nds_b kernel:
hda: timeout waiting for DMA
Feb 12 10:24:46 porte_de_clignancourt_nds_b kernel:
ide_dmaproc: chipset supported ide_dma_timeout func
only: 14
Feb 12 10:24:46 porte_de_clignancourt_nds_b kernel:
hda: status timeout: status=0xd0 { Busy }
Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
hda: drive not ready for command
Feb 12 10:24:47 porte_de_clignancourt_nds_b
ucd-snmp[813]: Connection from 104.1.3.11
Feb 12 10:24:47 porte_de_clignancourt_nds_b last
message repeated 4 times
Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
ide0: reset timed-out, status=0x80                   
le premier reser de ide0 est en échec
Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
hda: status timeout: status=0x80 { Busy }
Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
hda: drive not ready for command
Feb 12 10:24:47 porte_de_clignancourt_nds_b
ucd-snmp[813]: Connection from 104.1.3.11
Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
ide0: reset: success                                  
      
Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
hda: irq timeout: status=0xd0 { Busy }                

Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
hda: DMA disabled                                     
   
Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
ide0: reset timed-out, status=0x80
Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
hda: status timeout: status=0x80 { Busy }        
nouvel échec de reset
Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
hda: drive not ready for command
Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
ide0: reset: success                                  
    
Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
ide0: reset timed-out, status=0x80
Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
hda: status timeout: status=0x80 { Busy }
Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
hda: drive not ready for command
Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
ide0: reset timed-out, status=0x80
Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
end_request: I/O error, dev 03:02 (hda), sector 102263
Feb 12 13:45:38 porte_de_clignancourt_nds_b syslogd:
/var/log/maillog: Input/output error
Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
end_request: I/O error, dev 03:02 (hda), sector 110720
Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
end_request: I/O error, dev 03:02 (hda), sector 110728 


	

	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger ! Découvez les tarifs exceptionnels pour appeler la France et l'international.
Téléchargez sur http://fr.messenger.yahoo.com
