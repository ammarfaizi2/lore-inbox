Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271935AbRIMSJ2>; Thu, 13 Sep 2001 14:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271940AbRIMSJT>; Thu, 13 Sep 2001 14:09:19 -0400
Received: from puma.inf.ufrgs.br ([143.54.11.5]:49159 "EHLO inf.ufrgs.br")
	by vger.kernel.org with ESMTP id <S271935AbRIMSJF>;
	Thu, 13 Sep 2001 14:09:05 -0400
Date: Thu, 13 Sep 2001 15:09:51 -0300 (EST)
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Stomping on Athlon bug
In-Reply-To: <m1r8tbt5i7.fsf@frodo.biederman.org>
Message-ID: <Pine.GSO.4.21.0109131505170.25973-100000@jacui>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Sep 2001, Eric W. Biederman wrote:

> Jan Niehusmann <jan@gondor.com> writes:
> 
> > On Thu, Sep 13, 2001 at 08:21:49AM -0400, Arjan van de Ven wrote:
> > > On Thu, Sep 13, 2001 at 02:19:38PM +0200, Jan Niehusmann wrote:
> > > > But, as far as I understand, STPGNT will not be enabled unless ACPI
> > > > power saving is in use, so setting the disconnect on STPGNT bit should
> > > > not matter.
> > > 
> > > That is incorrect; it works perferctly well without ACPI.
> > 
> > Exactly what is incorrect?
> > AFAICS, STPGNT is not triggered by hlt, so the linux idle function
> > doesn't set STPGNT.
> 
> Hmm.  At least on the AMD76[12] you can trigger a processor disconnect
> on hlt.  However the buggy BIOS had disconnects disabled so it doesn't/shouldn't
> matter.

Perhaps this is connected to this question of the unofficial KT7A
motherboard, available at http://www.viahardware.com/faq/kt7/kt7faq.htm:

Why is my idle temperature so much higher under BIOS version 3R or later?

With previous BIOS versions ABIT set a bit in the BIOS CMOS (offset 52 bit
7) to "1" to enable the ACPI "HALT" function and cool down the CPU temp in
idle mode.  This, whilst allowing cooler CPU operation, is against the
advice of AMD and VIA.  Under earlier AMD processors, however, this
modification allowed the system to idle cooler and had no ill effects.  
However, it was been found with newer 133MHz FSB processors running at
1333MHz and higher, that this software cooling can cause severe stability
problems - especially under Windows 2000.  As a consequence, in all ABIT
BIOS releases after version 3R, ABIT have set this bit to "0" - the value
recommended by AMD and VIA.  This allows the motherboard to be stable with
all AMD processors at the expense of an increase of 5-10 degrees
Centigrade during idle (from approximately 35 degs C to 45 degs C).  This
will not harm your motherboard or processor.  Note that this CMOS setting
is widely used by other KT133/KT133A based motherboards.  Note that if
your processor is slower than 1333MHz then you can revert to the previous
setting of the BIOS by using H-Oda's WCPREDIT and WCPRSET programs to
modify this register value.  If you are using Hex mode in these programs
then change register 52 from 6B to EB to re-enable the software cooling.  
See downloads page for programs.

??


--
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/

