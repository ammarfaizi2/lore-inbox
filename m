Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289986AbSAKPXV>; Fri, 11 Jan 2002 10:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289985AbSAKPXH>; Fri, 11 Jan 2002 10:23:07 -0500
Received: from lila.inti.gov.ar ([200.10.161.32]:4063 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S289984AbSAKPXD>;
	Fri, 11 Jan 2002 10:23:03 -0500
Message-ID: <3C3F03CE.CDBB9A55@inti.gov.ar>
Date: Fri, 11 Jan 2002 12:25:03 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFCA] Sound: adding /proc/driver/{vendor}/{dev_pci}/ac97
In-Reply-To: <E16OUsF-00035V-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > > Also a card can have multiple ac97 codecs
> >
> > You are right, will also take care about it. Do you think
> > /proc/driver/{vendor}/{dev_pci}/{num_ac97}/ac97 will be ok?
>
> I'm dubious about the entire /proc entries. 8)

I implemented it like it /proc/driver/{vendor}/{dev_pci}/ac-97-{num_ac97}
in the second revision of the patch.
I want to know if the second revision is acceptable.
I found a bug when using more than 1 board (duplicated entries in
/proc/driver) and fixed it so I'm creating a third revision. I also moved a
debug /proc entry created by es1371 module to the new directory because the
current behavior doesn't allow to debug more than one board. I tested it
using 2 boards (it was pointed out by William Robinson). I also moved an
entry created for ALi boards to the new directory (is cleaner and nobody
commented about it), also renamed it with a descriptive name. This entry is
used to enable the SPDIF part of the codec so now it is:
/proc/driver/ali5451/{dev_pci}/spdif
Also allowing for more than one ALiM5451 in the same board (really bizarre
since this is usually part of the chipset but .... how knows?)

SET

P.S. I didn't get any reply from the es1371 maintainer, is he actively
maintaining the module? The status indicates he is active so I think I must
be patient:

PCI SOUND DRIVERS (ES1370, ES1371 and SONICVIBES)
P:      Thomas Sailer
M:      sailer@ife.ee.ethz.ch
L:      linux-sound@vger.kernel.org
W:      http://www.ife.ee.ethz.ch/~sailer/linux/pciaudio.html
S:      Maintained

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



