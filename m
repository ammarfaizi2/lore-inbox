Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277055AbRJMSQG>; Sat, 13 Oct 2001 14:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278343AbRJMSPr>; Sat, 13 Oct 2001 14:15:47 -0400
Received: from radium.jvb.tudelft.nl ([130.161.76.91]:12042 "HELO
	radium.jvb.tudelft.nl") by vger.kernel.org with SMTP
	id <S278341AbRJMSPo>; Sat, 13 Oct 2001 14:15:44 -0400
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: "'Ion Badulescu'" <ion@cs.columbia.edu>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: eepro100.c bug on 10Mbit half duplex (kernels 2.4.5 / 2.4.10 / 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
Date: Sat, 13 Oct 2001 20:16:33 +0200
Message-ID: <002601c15413$305938f0$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <Pine.LNX.4.33.0110120923010.7250-100000@guppy.limebrokerage.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001, Ion Badulescu wrote:

> > >  Receiver lock-up bug exists -- enabling work-around.
> > >  ^^^^^^^^^^^^^^^^^^^^
> >
> > My card DOES NOT have the receiver lock-up bug 
> 
> Your card's eeprom claims otherwise. The eeprom is most 
> likely wrong, but 
> again, the workaround for *this* bug is pretty harmless, 
> whether the bug 
> exists or not.
> 
> Ion
> 

Sorry, this was kind of a unlucky paste, because this line:

> > >  Receiver lock-up bug exists -- enabling work-around.
> > >  ^^^^^^^^^^^^^^^^^^^^

is from the previous sender's dmesg (Matthew S. Hallacy). *My card* does
not give this message, but it surely has a bug (which is not the
receiver lock-up bug).

Earlier, I was somewhat too quick with my conclusions. Since I upgraded
the link to 100 Mbit, also half duplex, the problem seemed gone. This
was NOT the case. The problem now only takes about 10 times as much
traffic to trigger.

* With vanilla kernel-2.4.13-pre2 the problem exists.
* With vanilla kernel-2.4.12-ac1 the problem exists.

So I added my device id to the 10 Mbit half-duplex workaround check, and
problem went away. For now. ;) I am gonna test this for some days and if
it stays put I will post the patch. Anyway, I should've stuck with 3com
:)

Regards,
- Robbert



