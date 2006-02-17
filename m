Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030654AbWBQVgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030654AbWBQVgU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWBQVgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:36:20 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:63694 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751437AbWBQVgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:36:19 -0500
Message-ID: <43F641A2.50200@tmr.com>
Date: Fri, 17 Feb 2006 16:35:30 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Daniel Barkalow <barkalow@iabervon.org>
CC: Greg KH <greg@kroah.com>, Nix <nix@esperi.org.uk>,
       Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <43D7AF56.nailDFJ882IWI@burner> <20060125173127.GR4212@suse.de>  <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix>  <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com>  <Pine.LNX.4.64.0602122256130.6773@iabervon.org>  <20060213062158.GA2335@kroah.com>  <Pine.LNX.4.64.0602130244500.6773@iabervon.org>  <20060213175142.GB20952@kroah.com> <d120d5000602131003l7bd1451bs64076475fdd6079c@mail.gmail.com> <Pine.LNX.4.64.0602131339140.6773@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0602131339140.6773@iabervon.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Barkalow wrote:

> I don't think it needs to be a class, but I think that there should be a 
> single place with a directory for each device that could be what you want, 
> with a file that tells you if it is. That's why I was looking at block/; 
> these things must be block devices, and there aren't an huge number of 
> block devices.
> 
> I suppose "grep 1 /sys/block/*/device/dvdwriter" is just as good; I hadn't 
> dug far enough in to realize that the reason I wasn't seeing anything 
> informative in /sys/block/*/device/ was that I didn't have any devices 
> with informative drivers, not that it was actually supposed to only have 
> links to other things.

It would be nice to have one place to go to find burners, and to have 
the model information in that place. I would logically think that place 
is sysfs, and I know the kernel has the information because if I root 
through /proc/bus/usb and /proc/scsi/scsi, and /proc/ide/hd?/model I can 
eventually find out what the system has connected.

I not entirely sure about having classes other than cdrom, just because 
we already have CD, DVD, DVD-DL, and are about to add blue-ray and 
HD-DVD, so if I can tell that it's a removable device which can read 
CDs, the applications have a fighting chance to looking at the device to 
see what it is. As a human I would like the model information because 
the kernel has done the work, why should people have to chase it when it 
could be in one place?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
