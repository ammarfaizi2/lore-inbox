Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbTJDWVM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 18:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTJDWVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 18:21:12 -0400
Received: from 200-184-148-66.dba.com.br ([200.184.148.66]:57798 "EHLO
	SCUTUM.dba.com.br") by vger.kernel.org with ESMTP id S262783AbTJDWVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 18:21:10 -0400
Message-ID: <A36146B96FA84B4BB69EB088451E965A080CE793@cygnus>
From: Juan Carlos Castro Y Castro <jcastro@dba.com.br>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel doesn't see USB ADSL modem - pegasus?
Date: Sat, 4 Oct 2003 19:17:57 -0300 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<caveman-trying-to-understand-black-monolith>
So I should insert the following line in pegasus.h?

PEGASUS_DEV( "SpeedStream 5200 ADSL Modem", VENDOR_SIEMENS, 0xe240,
                DEFAULT_GPIO_RESET | PEGASUS_II )

Is the first string free to choose or do I have to match some output from
the device? Anyway, I'll try it tonight or tomorrow.
</caveman-trying-to-understand-black-monolith>

By the way, USB and ACPI are nice to each other again. Thanks Jun! You're
better at your craft than your distant relative Satoru
(http://www.grandprix.com/gpe/drv-naksat.html) was at his!

Cheers all,
Juan

-----Original Message-----
From: Greg KH
To: Juan Carlos Castro Y Castro
Cc: 'linux-kernel@vger.kernel.org'
Sent: 10/4/2003 6:39 PM
Subject: Re: Kernel doesn't see USB ADSL modem - pegasus?

On Sat, Oct 04, 2003 at 02:10:57AM -0300, Juan Carlos Castro Y Castro
wrote:
> (Please CC me here and at jcastro@vialink.com.br -- I'm not
subscribed)
> 
> I have a SpeedStream 5200 ADSL modem, connected to the USB port. From
what I
> understand, the pegasus driver should see it. I installed 2.4.23-pre6,
> modprobe'd usbnet and pegasus, but no new interface shows up. (I
tested with
> ip link show)
> 
> Maybe I should patch the driver to include a device ID or something of
the
> sort?

Try that, the driver currently does not support this device id.  Let us
know how that works.

thanks,

greg k-h

**********************************************************************
 Informação transmitida destina-se apenas à pessoa a quem foi endereçada e pode conter informação confidencial, legalmente protegida e para conhecimento exclusivo do destinatário. Se o leitor desta advertência não for o seu destinatário, fica ciente de que sua leitura, divulgação ou cópia é estritamente proibida. Caso a mensagem tenha sido recebida por engano, favor comunicar ao remetente e apagar o texto de qualquer computador.


The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information, by person or entity other than the intended recipient is prohibited. If you received this in error, please contact the sender and delete the material from any computer.
**********************************************************************
