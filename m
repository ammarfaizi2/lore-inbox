Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUAFShE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUAFSeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:34:22 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30443 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264894AbUAFSde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:33:34 -0500
Date: Tue, 6 Jan 2004 19:33:25 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: patmans@ibm.com, neuffer@goofy.zdv.uni-mainz.de, a.arnold@kfa-juelich.de
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: 2.6.1-rc1: SCSI: `TIMEOUT' redefined
Message-ID: <20040106183325.GJ11523@fs.tum.de>
References: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 12:36:49AM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.6.0 to v2.6.1-rc1
> ============================================
>...
> Patrick Mansfield:
>   o consolidate and log scsi command on send and completion
>...

This adds a #define TIMEOUT to scsi.h conflicting with a different 
TIMEOUT #define in drivers/scsi/eata_generic.h:

<--  snip  -->

...
  CC      drivers/scsi/eata_pio.o
In file included from drivers/scsi/eata_pio.c:69:
drivers/scsi/eata_generic.h:84: warning: `TIMEOUT' redefined
include/scsi/scsi.h:305: warning: this is the location of the previous definition
...

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

