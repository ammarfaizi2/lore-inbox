Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317078AbSFFTXY>; Thu, 6 Jun 2002 15:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSFFTXX>; Thu, 6 Jun 2002 15:23:23 -0400
Received: from host.greatconnect.com ([209.239.40.135]:15623 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S317078AbSFFTXW>; Thu, 6 Jun 2002 15:23:22 -0400
Subject: Re: PDC20267 + RAID can't find raid device
From: Samuel Flory <sflory@rackable.com>
To: William Thompson <wt@electro-mechanical.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020606111918.F7291@coredump.electro-mechanical.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Jun 2002 12:18:14 -0700
Message-Id: <1023391095.3423.112.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  It works for me once I got the right options.  Did you enable the
"fasttrak feature"

I'm using the following options in my .config:
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_ATARAID_PDC=y

  One major issue for me is that you can use, and mount both the
/dev/ataraid/d0 devices, and the /dev/hd devices.  This makes for lots
of fun in the Red Hat installer, and Cerberus.   


On Thu, 2002-06-06 at 08:19, William Thompson wrote:
> After trying 2.4.19-pre10-ac2 I can finally use the PDC20267 controller,
> however, it doesn't find any raid devices.
> 
> I have 2 quantum fireballlct10 05 on the controller (hde and hdg) and
> created a stripe between these 2 disks in the controller's bios.
> 
> I can see both disks w/o problems.
> 
> I'd rather not use the linux software raid since you can't partition it.
> 
> IDE, PDC20267, FastTrak, and the raid driver are all compiled into the
> kernel.
> 
> More info is available at request.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


