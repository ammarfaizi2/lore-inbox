Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbUACWqk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbUACWqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:46:40 -0500
Received: from web40602.mail.yahoo.com ([66.218.78.139]:3501 "HELO
	web40602.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263836AbUACWqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:46:37 -0500
Message-ID: <20040103224636.5738.qmail@web40602.mail.yahoo.com>
Date: Sat, 3 Jan 2004 23:46:36 +0100 (CET)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: IDE performance drop between 2.4.23 and 2.6.0 - pinpointed!
To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040103220159.GA22096@sun1000.pwr.wroc.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl> a écrit : >
hi,
> 
> same problem here however it seems that i have pinpointed it
> )at least
> for me):
> 

from the manpage of hdparm:
       -t     Perform timings of device reads for benchmark and 
compari-
              son  purposes.   For  meaningful  results,  this 
operation
              should be repeated 2-3 times on an otherwise
inactive  sys-
              tem  (no  other active processes) with at least a
couple of
              megabytes of free memory. 
 

if the above conditions are not met your test is irrelevant 

> funny (? ;-) thing is that under 2.4 i have same issue...
> 
> my chipset is kt133 (via), i use uhci.
> 
> root@localhost:~ # cat /proc/interrupts 
>            CPU0       
>   0:    2283127          XT-PIC  timer
>   1:       4896          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   8:          1          XT-PIC  rtc
>   9:          0          XT-PIC  acpi
>  10:          0          XT-PIC  eth0, VIA686A
>  11:     271497          XT-PIC  uhci_hcd, uhci_hcd
>  12:     171840          XT-PIC  bttv0, nvidia
>  14:      33427          XT-PIC  ide0
>  15:          1          XT-PIC  ide1
> NMI:          0 
> ERR:          4
> 
> tested under pure 2.6.0.  ac scheduler, same under noop and
> dead.
> 
> regards, Pawel
> 
> ps. i read the list via www so cc my the replies please.
> thanks.
> -- 
> Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS
> avatar:0:0:
> Wroclaw Networking & Supercomputing Center, HPC Department
> -> See message headers for privacy policy info.
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=====
--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.

_________________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
