Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbTCGWyF>; Fri, 7 Mar 2003 17:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbTCGWyF>; Fri, 7 Mar 2003 17:54:05 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:3087
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S261831AbTCGWx6>; Fri, 7 Mar 2003 17:53:58 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DD3@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Bryan Whitehead'" <driver@jpl.nasa.gov>
Cc: linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RE: devfs + PCI serial card = no extra serial ports
Date: Fri, 7 Mar 2003 15:04:33 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

What serial driver initialization messages do you get from dmesg?
Is the "MANY_PORTS" flag present in the list of enabled options?
Which distribution and rev level are you using?

Ed

-----Original Message-----
From: Bryan Whitehead [mailto:driver@jpl.nasa.gov]
Sent: Friday, March 07, 2003 2:55 PM
To: linux-kernel@vger.kernel.org
Cc: linux-newbie@vger.kernel.org
Subject: Re: devfs + PCI serial card = no extra serial ports



BTW, this is with 2.4.19 (kernel shipped with distro).... I'm willing to 
test any patches / rebuild kernel to get this working.....


Bryan Whitehead wrote:
> It seems devfsd has an annoying "feature". I bought a PCI card to get a 
> couple (2) more serial ports. The kernel doesn't seem to set up the 
> serial ports at boot, so devfs never creates an entry. However, post 
> boot, since there is no entries, I cannot configure the serial ports 
> with setserial. So basically devfsd = no PCI based serial add on?
> 
> 03:05.0 Serial controller: NetMos Technology 222N-2 I/O Card (2S+1P) 
> (rev 01) (prog-if 02 [16550])
>     Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device 
> 0002
>     Flags: medium devsel, IRQ 17
>     I/O ports at ecf8 [size=8]
>     I/O ports at ece8 [size=8]
>     I/O ports at ecd8 [size=8]
>     I/O ports at ecc8 [size=8]
>     I/O ports at ecb8 [size=8]
>     I/O ports at eca0 [size=16]
> 
> 
> mknod ttyS2 c 4 66
> mknod ttyS3 c 4 67
> setserial ttyS2 port 0xecf8 UART 16550A irq 17 Baud_base 9600
> setserial ttyS3 port 0xece8 UART 16550A irq 17 Baud_base 9600
> 
> I hoped after "setting up" the serial ports with setserial some magic 
> would happen and they would apear in /dev/tts... but I was wrong.
> 
> gets me working serial ports... but it's not in /dev... :O
> 
> Am I just screwed?
> 
> If so, what would be a good add on PCI based solution for more serial 
> ports that WORKS with devfsd? (I don't want to disable devfs as this 
> opens up a different set of problems)
> 
> Thanks for any replay!
> 


-- 
Bryan Whitehead
SysAdmin - JPL - Interferometry Systems and Technology
Phone: 818 354 2903
driver@jpl.nasa.gov

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
