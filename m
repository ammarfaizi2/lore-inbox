Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266956AbRGHS1t>; Sun, 8 Jul 2001 14:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266957AbRGHS13>; Sun, 8 Jul 2001 14:27:29 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:57095 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S266956AbRGHS1U>; Sun, 8 Jul 2001 14:27:20 -0400
Message-ID: <3B48A643.124AA832@t-online.de>
Date: Sun, 08 Jul 2001 20:28:19 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Gregory (Grisha) Trubetskoy" <grisha@ispol.com>
Subject: ESCD Support for 2.4.6-ac1/PNPBIOS (was: reading/writing CMOS beyond 256 
 bytes?)
In-Reply-To: <E15IXCD-0004Uu-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
with a litte patch to linux-2.4.6ac1 (which includes PNPBIOS)
the ESCD data is easily accessible.

Then "lsescd" will verbosely decode /proc/bus/pnp/escd.

This lets you access important info which would be beneficial for correctly
configuring PnP in Linux (e.g. when you set an IRQ to "reserved for legacy ISA"
in your BIOS setup or you can see what's the difference between selecting
"_PNP OS_" to yes/no in your BIOS setup screen).

Regards, Gunther

P.S. There is an additional potential benefit for ISAPNP: you can
get the PNP Port configured by your BIOS. Previously all cards had
to be reset to use a new port. Linux suffers serverly from not
doing PnP failsafe, burdening configuration tasks onto the user.

cat /proc/bus/pnp/pnpconfig_info 
Revision=1 No_Csn=1 ISAPNP_Port=0x20b
                                  ^^^

Download from:
http://home.t-online.de/home/gunther.mayer/lsescd-0.10.tar.bz2



Alan Cox wrote:
> 
> > Unfortunately, it seems that some settings are not in the 128 (or 256)
> > bytes accessible this way, so they must be stored elsewhere.
> 
> Large numbers of BIOS settings are in the NVRAM ESCD area in modern systems
> (EISA config, ISAPNP config, etc)
> 
> > Does anyone know where I should look for the remaining parts of CMOS
> > (short of having to sign some NDA with Intel?)?
> 
> The PnPBIOS and ESCD specs are publically available if a little impenetrable
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
