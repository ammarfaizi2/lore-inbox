Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291451AbSBHHWZ>; Fri, 8 Feb 2002 02:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291452AbSBHHWH>; Fri, 8 Feb 2002 02:22:07 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:11280 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291451AbSBHHV4>; Fri, 8 Feb 2002 02:21:56 -0500
Date: Fri, 8 Feb 2002 08:21:41 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: John Weber <weber@nyc.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.4-pre3 and IDE changes
Message-ID: <20020208082141.C2995@suse.cz>
In-Reply-To: <3C634346.1010405@nyc.rr.com> <Pine.LNX.4.10.10202071953330.15165-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10202071953330.15165-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Thu, Feb 07, 2002 at 07:54:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 07:54:09PM -0800, Andre Hedrick wrote:
> 
> I repeat that is a diagnostic layer and is to never be called from the
> kernel, it is a user-space only and will go away.

But it should compile nevertheless, shouldn't it?

> 
> On Thu, 7 Feb 2002, John Weber wrote:
> 
> > The address member of struct scatterlist appears to have been changed to 
> > dma_address.
> > 
> > A simple s/\.address/\.dma_address/ should fix this compile error.
> > 
> > ide-dma.c: In function `ide_raw_build_sglist':
> > ide-dma.c:269: structure has no member named `address'
> > ide-dma.c:276: structure has no member named `address'
> > make[3]: *** [ide-dma.o] Error 1
> > make[3]: Leaving directory `/usr/src/linux-2.5.4/drivers/ide'
> > make[2]: *** [first_rule] Error 2
> > make[2]: Leaving directory `/usr/src/linux-2.5.4/drivers/ide'
> > make[1]: *** [_subdir_ide] Error 2
> > make[1]: Leaving directory `/usr/src/linux-2.5.4/drivers'
> > make: *** [_dir_drivers] Error 2
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> Andre Hedrick
> Linux Disk Certification Project                Linux ATA Development
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
