Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279421AbRJWN0Z>; Tue, 23 Oct 2001 09:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279424AbRJWN0P>; Tue, 23 Oct 2001 09:26:15 -0400
Received: from web12308.mail.yahoo.com ([216.136.173.106]:50948 "HELO
	web12308.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S279421AbRJWNZ4>; Tue, 23 Oct 2001 09:25:56 -0400
Message-ID: <20011023132630.88943.qmail@web12308.mail.yahoo.com>
Date: Tue, 23 Oct 2001 06:26:30 -0700 (PDT)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: [PATCH} cpqfc, eliminate virt_to_bus + fix passthrough bug
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch description:
   * reinitialize Cmnd->SCp.sent_command (used to identify commands as
     passthrus) on calling scsi_done, since the scsi mid layer does not
     use (or reinitialize) this field to prevent subsequent comands from
     having it set incorrectly. 

   * Revise driver to use new kernel 2.4.x PCI DMA API, instead of 
     virt_to_bus().  (enables driver to work w/ ia64 systems with >2Gb RAM.)
     Rework main scatter-gather code to handle cases where SG element
     lengths are larger than 0x7FFFF bytes and use as many scatter 
     gather pages as necessary. (Steve Cameron)
   * Makefile changes to bring cpqfc into line w/ rest of SCSI drivers
     (thanks to Keith Owens)

Patch is large, so it's here:
http://www.geocities.com/dotslashstar/cpqfc_2.1.1_for_2.4.12-ac5.txt

Patch applies to 2.4.12-ac5 and to 2.4.13-pre6.

-- steve
(aka steve.cameron@compaq.com)


__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
