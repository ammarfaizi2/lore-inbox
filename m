Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319294AbSH2TGB>; Thu, 29 Aug 2002 15:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319295AbSH2TGA>; Thu, 29 Aug 2002 15:06:00 -0400
Received: from [63.122.107.34] ([63.122.107.34]:64274 "EHLO
	alderaan.coastal-credit.com") by vger.kernel.org with ESMTP
	id <S319294AbSH2TF7>; Thu, 29 Aug 2002 15:05:59 -0400
Message-Id: <5.1.0.14.0.20020829150955.02adf008@imap.coastalcreditllc.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 29 Aug 2002 15:10:22 -0400
To: linux-kernel@vger.kernel.org
From: James Di Toro <jditoro3@coastalcreditllc.com>
Subject: Passing kernel parameters
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I went ahead on a new server and decided to set up a 2.4 kernel.  Since 
this was going to be a cdimage server I needed what ever HD power I could 
get out of it, and more than the standard 8 loop devices.  Looking around I 
found that I should just be able to pass the 'idebus' and 'max_loop' 
parameters to the kernel instead of having to rebuild a kernel.

Unfortunately this is not working.  dmesg for ide still shows the following:

         ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx

despite the fact that I've specified 'idebus=66' and the following lines note:

         VP_IDE: VIA vt82c596b (rev 12) IDE UDMA66 controller on pci00:07.1

and unless I actually pass 'max_loop=255' on an insmod line mounting the 
first loop device gives me:

         loop: loaded (max 8 devices)

I've tried this w/ the parameters as an append line both globaly and in the 
specific kernel stanza I'm loading.  I've tried just the idebus parameter 
alone since the max_loop parameter isn't as critical on boot (I have other 
scripts mounting the 'cds').

Am I doing something wrong here?  I just don't see where I've not done what 
the docs say.

-- 
Till Later,
Jake

