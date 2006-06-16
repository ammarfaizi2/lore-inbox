Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWFPRKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWFPRKq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 13:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWFPRKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 13:10:46 -0400
Received: from father.pmc-sierra.com ([216.241.224.13]:1438 "HELO
	father.pmc-sierra.bc.ca") by vger.kernel.org with SMTP
	id S1750887AbWFPRKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 13:10:45 -0400
Message-ID: <9328C220997E4E448CC833AF1AB402DA0344D906@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From: Shane McDonald <Shane_McDonald@pmc-sierra.com>
To: "'Jean Delvare'" <khali@linux-fr.org>, linux-mips@linux-mips.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: RE: i2c-algo-ite and i2c-ite planned for removal
Date: Fri, 16 Jun 2006 10:10:33 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

  PMC-Sierra has an eval board (the "Xiao Hu") that uses these files.  We haven't (yet) pushed out patches to add support for this board, but we hope to at some time.  The kernel we use on the board is based on 2.6.14, so I could generate a patch so that these files will compile against 2.6.14.  I'm guessing the patch will also apply to 2.6.16.20, since these files haven't changed for so long.

  I'll put together the patch and make sure it's still correct against 2.6.16.20, then submit it.

Shane

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Jean Delvare
> Sent: Thursday, June 15, 2006 2:57 PM
> To: linux-mips@linux-mips.org; LKML
> Subject: i2c-algo-ite and i2c-ite planned for removal
> 
> Hi all,
> 
> I noticed today that we have an i2c bus driver named i2c-ite,
> supposedly useful on some MIPS systems which have an ITE8172 chip,
> which doesn't compile. It is based on an i2c algorithm driver named
> i2c-algo-ite, which doesn't compile either, due to some 
> changes made to
> the i2c core which weren't properly reflected there. Going back trough
> the versions, I found that the bus driver was previously named
> i2c-adap-ite, and was introduced in 2.4.10. And I don't think it even
> compiled back then either, as it uses a structure (iic_ite) 
> which isn't
> defined anywhere.
> 
> So basically we have two drivers in the kernel tree for 5 years or so,
> which never were usable, and nobody seemed to care. It's about time to
> get rid of these 1296 lines of code, don't you think? So, 
> unless someone
> volunteers to take care of these drivers, or otherwise has a very
> strong reason to object, I'm going to delete them from the tree soon.
> 
> Thanks,
> -- 
> Jean Delvare
> 
