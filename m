Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265180AbRGEWcI>; Thu, 5 Jul 2001 18:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbRGEWb6>; Thu, 5 Jul 2001 18:31:58 -0400
Received: from sncgw.nai.com ([161.69.248.229]:16824 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S265180AbRGEWbs>;
	Thu, 5 Jul 2001 18:31:48 -0400
Message-ID: <XFMail.20010705153503.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010705151725.A6021@kroah.com>
Date: Thu, 05 Jul 2001 15:35:03 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Greg KH <greg@kroah.com>
Subject: Re: about include/linux/macros.h ...
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05-Jul-2001 Greg KH wrote:
> On Wed, Jul 04, 2001 at 04:33:51PM -0700, Davide Libenzi wrote:
>> 
>> What about the creation of such file containing useful macros like min(),
>> max(), abs(), etc.. that otherwise everyone is forced to define like :
> 
> See include/linux/netfilter.h, around line 164 for the reason why there
> isn't a kernel wide min() or max() macro.

Ok, let's continue like this :

./fs/ufs/util.h:#define min(x,y)                ((x)<(y)?(x):(y))
./fs/ntfs/macros.h:#define min(a,b)     ((a) <= (b) ? (a) : (b))
./include/linux/mtd/cfi.h:#define min(x,y) ( (x)<(y)?(x):(y) )
./include/linux/wanpipe.h:#define min(a,b) (((a)<(b))?(a):(b))
./include/linux/cyclomx.h:#define min(a,b) (((a)<(b))?(a):(b))
./include/linux/lvm.h:#define min(a,b) (((a)<(b))?(a):(b))
./net/khttpd/prototypes.h:#define min(a,b)  ( (a) < (b) ? (a) : (b) )
./drivers/net/wan/comx.h:#define min(a,b)               ((a) > (b) ? (b) : (a))
./drivers/net/hamradio/soundmodem/sm.h:#define min(a, b) (((a) < (b)) ? (a):(b))
./drivers/char/agp/agp.h:#define min(a,b)       (((a)<(b))?(a):(b))
./drivers/scsi/eata_generic.h:#define min(a,b) ((a<b)?(a):(b))
./drivers/sound/emu10k1/hwaccess.h:#define min(x,y) ((x) < (y)) ? (x) : (y)
./drivers/sound/dmasound/dmasound.h:#define min(x, y)   ((x) < (y) ? (x) : (y))
./drivers/video/cyberfb.h:#define min(a,b)      ((a) < (b) ? (a) : (b))
./drivers/acorn/scsi/acornscsi.h:#define min(x,y) ((x) < (y) ? (x) : (y))
./drivers/usb/usb-ohci.h:#define min(a,b) (((a)<(b))?(a):(b))
./drivers/usb/usb-uhci.h:#define min(a,b) (((a)<(b))?(a):(b))
./drivers/telephony/ixj.h:#define min(a,b) (((a)<(b))?(a):(b))
./arch/cris/drivers/usb-host.h:#define min(a,b) (((a)<(b))?(a):(b))            
./fs/ufs/util.h:#define max(x,y)  ((x)>(y)?(x):(y))
./fs/ntfs/macros.h:#define max(a,b)     ((a) >= (b) ? (a) : (b))
./include/linux/wanpipe.h:#define max(a,b) (((a)>(b))?(a):(b))
./include/linux/cyclomx.h:#define max(a,b) (((a)>(b))?(a):(b))
./include/linux/lvm.h:#define max(a,b) (((a)>(b))?(a):(b))
./net/khttpd/prototypes.h:#define max(a,b)  ( (a) > (b) ? (a) : (b) )
./drivers/net/wan/comx.h:#define max(a,b)               ((a) > (b) ? (a) : (b))
./drivers/net/hamradio/soundmodem/sm.h:#define max(a, b) (((a) > (b)) ? (a):(b))
./drivers/video/cyberfb.h:#define max(a,b)      ((a) > (b) ? (a) : (b))
./drivers/acorn/scsi/acornscsi.h:#define max(x,y) ((x) < (y) ? (y) : (x))
./drivers/telephony/ixj.h:#define max(a,b) (((a)>(b))?(a):(b))                 
                                             



- Davide

