Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbTABBDo>; Wed, 1 Jan 2003 20:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbTABBDo>; Wed, 1 Jan 2003 20:03:44 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16519
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265250AbTABBDn>; Wed, 1 Jan 2003 20:03:43 -0500
Subject: Re: RH7.3 Updates - Compile Issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Randy Broman <rbroman@bayarea.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E139144.9020806@bayarea.net>
References: <3E139144.9020806@bayarea.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Jan 2003 01:54:50 +0000
Message-Id: <1041472490.22587.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-02 at 01:09, Randy Broman wrote:
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.18-19.7.x/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe 
> -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I 
> /usr/lib/gcc-lib/i386-redhat-linux/2.96/include -DKBUILD_BASENAME=serial  
> -DEXPORT_SYMTAB -c serial.c
> serial.c: In function `rs_read_proc':
> serial.c:3361: Internal error: Segmentation fault.
> Please submit a full bug report.
> See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.

> I then did some further testing and found I was unable to compile some
> software that previously compiled successfully. Ideas appreciated ..

gcc tends to show up hardware problems, however if you could use the old
compiler reliably thats not neccessarily fitting the pattern well. 

rpm --verify will let you check packages installed correctly

In general though
If the error is at the same spot each time - suspect software
If the error is in different spots when you rerun the same make -
suspect hardware

Also check you have swap space so are not running out of RAM

