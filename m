Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263680AbRFCTrc>; Sun, 3 Jun 2001 15:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263747AbRFCTrV>; Sun, 3 Jun 2001 15:47:21 -0400
Received: from mailrelay.bluelabs.se ([194.17.38.34]:60176 "HELO
	mailrelay.bluelabs.se") by vger.kernel.org with SMTP
	id <S263680AbRFCSA2>; Sun, 3 Jun 2001 14:00:28 -0400
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>, Shane Wegner <shane@cm.nu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andre@aslab.com (Andre Hedrick), magnus.sandberg@test.bluelabs.se,
        linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
From: Magnus.Sandberg@bluelabs.se
Subject: Re: Problem with kernel 2.2.19 Ultra-DMA and SMP, once more
MIME-Version: 1.0
Date: Sun, 3 Jun 2001 20:00:19 +0200
Message-ID: <OF4FB437BF.F57C2D04-ONC1256A60.0062E7E7@bluelabs.se>
X-MIMETrack: Serialize by Router on Blue-sth3/srv/Bluelabs(Release 5.0.6a |January 17, 2001) at
 2001-06-03 20:00:20
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I guess there are no simple answers... Below I have 3 different answers to
my
previous questions. As they relate to the same problem,I descided to put
them togheter in this mail.

Mark Hahn don't realy seams to agree with Andre about if noapic is
crippling
the system or not.

Alan Cox says that VIA and SMP are not supported for the moment by 2.2.
What does that mean? Can I use it at all or do I risk to get hardware
damage
of my motherboard or just an unstable system?

Shane Wegner seams to have some sort of work-around by mixing new and old
versions of IDE-patch.


>From all this I have a new three-stage question;

Is it just luck that Shane got it working?
Or do I have to wait for 2.2.20 or go for 2.4 (which I'm not mentally
prepered for...)?
Or how crippled is a system without APIC?

                                  _\\|//_
                                  (-0-0-)
/-------------------------------ooO-(_)-Ooo------------------------------\
| Magnus Sandberg                    Email: Magnus.Sandberg@bluelabs.se  |
| Network Engineer, Bluelabs                     http://www.bluelabs.se/ |
| Phone: +46-8-470 2155    (FAX: +46-8-470 2199)    GSM: +46-708-225 805 |
\------------------------------------------------------------------------/
                                  ||   ||
                                 ooO   Ooo



 ----- On 2nd of June 2001 Mark Hahn wrote; -----

> Will the APIC-problems be solved in the future or do I have to deside
upon
> running "noapic" semi-crippled or not run Ultra-DMA?

noapic is *not* semi-crippled.  it may even be faster than apic mode.
turning off udma, though, that's definitely crippling.



 ----- On 2nd of June 2001 Alan Cox wrote; -----

> Hi Andre,
> The motherboard has VIA-chipset.

2.2 does not support VIA SMP. 2.4 should get it right. 2.2.20 may support
it
but I'm working on a 3 month schedule for 2.2.20



 ----- On 3rd of June 2001 Shane Wegner wrote; -----

On Fri, Jun 01, 2001 at 10:03:47PM +0200, Magnus.Sandberg@bluelabs.se
wrote:

> Hi again,
>
> Earlier today I wrote about my SMP and Ultra-DMA problem. Now have I
> written down the boot information. I hope that the attachment show the
> correct information, it was written in W*rd so some lower case chars can
> have been converted into upper case...
>
> I also checked the IDE-patch and the filename was
> kernel-patch-2.2.19-ide_20010325-1.tar.gz.
> Could a newer IDE-patch handle SMP better than this one?

Not presently however an older one can.  I posted on this a
few weeks back and what worked for me was to get the IDE
patch ide-2.2.19.05042001 from
ftp.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.19.
That is the most recent as of this writing.  Then replace
the via82cxxx.c driver which that created by patching
2.2.18 with ide-2.2.18.1221.

This allowed me to boot fine with VIA SMP and everything
works well.

Regards,
Shane

