Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbTGJAkT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 20:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266202AbTGJAkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 20:40:19 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:59115 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S266097AbTGJAkP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 20:40:15 -0400
Message-ID: <3F0CB842.2050102@rackable.com>
Date: Wed, 09 Jul 2003 17:50:10 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>
CC: linux-kernel@vger.kernel.org, mru@users.sourceforge.net
Subject: Re: Promise SATA 150 TX2 plus
References: <Pine.LNX.4.53.0307091413030.683@mx.homelinux.com> <027901c3461e$e023c670$401a71c3@izidor> <yw1xadbnx017.fsf@users.sourceforge.net> <02ff01c34642$5512d7f0$401a71c3@izidor> <3F0C5D55.4030304@rackable.com> <039701c34675$81a8b0e0$401a71c3@izidor> <3F0CB01F.5070308@rackable.com> <03dd01c3467a$7281a7c0$401a71c3@izidor>
In-Reply-To: <03dd01c3467a$7281a7c0$401a71c3@izidor>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2003 00:54:54.0457 (UTC) FILETIME=[E04DFE90:01C3467D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milan Roubal wrote:

>So what about the main advantage of SATA, that is hot-swap?
>
  Hot swap is really only in the second SATA spec.  Also hotswap is 
generally only support on scsi devices, usb devices, and raid controllers.

>Is it possible to make hotswap in the linux and change it for the
>same disk? 
>
  You used to be able to hot swap with sca scsi drives doing the following:

1)Echo some wierd command to /proc/scsi/scsi to remove the device.
2)Physically swap drives
3)Echo some wierd command to /proc/scsi/scsi to add the device.

See scsi.c 3rd, and 4th instances of the word "echo" for details.

  Of course a number of scsi raid controllers support of replacing of 
failed drives, and automagic rebuild on the new drive.  This requires a 
saf-te backplane, and a saf-te compatible raid controller. 

  In theroy you can do this on a 3ware pata, and sata controller with 
the 7.6 firmware, the 7.6 cli, and ide hotswap backplane.  Personally 
I've never tried it with a jbod drive.

>Or is it possible to change it for other disk with other
>geometry? Is it depending on SATA controller or I only need
>support in the linux kernel? Is there that support for this
>controllers/drives?
>  
>
  If might be possible if you had a controller that supported the 2nd 
sata spec, a hot swap drive carrier and used the ata-scsi driver.  Then 
the same echo trick for scsi might work.  More likely bad things would 
occur.

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


