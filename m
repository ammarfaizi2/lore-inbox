Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTIAWvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 18:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTIAWvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 18:51:33 -0400
Received: from h002.c000.snv.cp.net ([209.228.32.66]:40151 "HELO
	c000.snv.cp.net") by vger.kernel.org with SMTP id S263351AbTIAWts
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 18:49:48 -0400
X-Sent: 1 Sep 2003 22:49:44 GMT
From: Brien <admin@brien.com>
To: JD Gray <kahdgarxi@grayserv.com>
Subject: Re: siimage 1.06 in kernel 2.6
Date: Sun, 31 Aug 2003 18:49:08 -0400
User-Agent: KMail/1.5.3
References: <1062453091.2075.13.camel@mikhail.grayserv.com>
In-Reply-To: <1062453091.2075.13.camel@mikhail.grayserv.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308311849.08124.admin@brien.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just wondering if maybe DMA mode isn't on when you get this "~1.5MB/s" speeds, 
regardless of the driver version (maybe one doesn't set it automatically) (?)

Do you use hdparm to get these speeds? Check if DMA is on by using hdparm -i 
/dev/hd? (change to your device of course) , if it's not try e.g. hdparm -d1 
-X66 /dev/hd? (X66=ultra DMA 2 if your device supports that or even try 
multiword, example X34=multiword DMA 2)

Brien

On Monday 01 September 2003 05:51 pm, JD Gray wrote:
> I use an SiS SATA controller that uses the siimage driver
> (drivers/ide/pci/siimage.c) I have an -ac 2.4 kernel that uses version
> 1.06 of this driver, and it works very well (~65MB/s). Kernel 2.6 on the
> other hand has version 1.02 of this driver which gets very poor
> preformance (~1.5MB/s.) I would like to know if anyone is working on
> getting 1.06 into the 2.6 kernel. (I've tried several ways to get it
> working including copying the .c straight from my kernel and patch
> posted on this mailing list. Neither worked, it wouldn't compile either
> time.) If no one is, then this is a request per say. If anyone has time
> and/or is able to put this new driver into the 2.6 kernel I would be
> greatly thankful. Thanks alot
> -JD Gray
> (KahdgarXI)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

