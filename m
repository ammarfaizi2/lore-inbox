Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbUDAMe0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 07:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbUDAMe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 07:34:26 -0500
Received: from [195.23.16.24] ([195.23.16.24]:29384 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262890AbUDAMeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 07:34:16 -0500
From: "Rui Santos" <rsantos@grupopie.com>
To: "'mohanlal jangir'" <mohanlal@samsung.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: UART detection?
Date: Thu, 1 Apr 2004 13:36:36 +0100
Organization: GrupoPIE, Portugal S.A.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <009401c417db$da971e70$7f476c6b@sisodomain.com>
Thread-Index: AcQX38aU7zBfXhEMT9iNMovbFOH+2wABWaQg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-Id: <20040401123419.152B1337F4@rd-server.pie.domain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I do not fully understand what you mean by 'detect this inside a kernel
module'. I think you want to compile it as a module and the modprobe it to
get the module messages.

If you compile the serial as a module on:
- Device Drivers -> Character Devices -> Serial Drivers -> 8250/16550 Serial
	you will get a module called serial.o

Remember that if you want do use modprobe to redirect the module messages,
You need to turn off the 'Automatic Module loadind when compiling the
kernel. You can do this ao Loadable Module Support -> Automatic Kernel
Module Loading.

Hope it helps
Regards,
Rui Santos



-----Mensagem original-----
De: mohanlal jangir [mailto:mohanlal@samsung.com] 
Enviada: quinta-feira, 1 de Abril de 2004 12:24
Para: Rui Santos
Cc: linux-kernel@vger.kernel.org
Assunto: Re: UART detection?

I want to detect this inside a kernel module. Any way to do it?

Regards
Mohanlal

----- Original Message -----
From: "Rui Santos" <rsantos@grupopie.com>
To: "'mohanlal jangir'" <mohanlal@samsung.com>
Sent: Thursday, April 01, 2004 4:56 PM
Subject: RE: UART detection?


> Hi,
>
> You can find them on the kernel boot messages.
> Something like: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>
> This log is usualy found at /var/log/messages
>
> Regards
> Rui Santos
>
>
> -----Mensagem original-----
> De: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] Em nome de mohanlal jangir
> Enviada: quinta-feira, 1 de Abril de 2004 12:02
> Para: linux-kernel@vger.kernel.org
> Assunto: UART detection?
>
> How can I find in a kernel module, how many UARTs are present in my
system?
> And how can I find their IO address and IRQ?
>
> Regards
> Mohanlal
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>



