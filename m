Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313859AbSDPT6Y>; Tue, 16 Apr 2002 15:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313862AbSDPT6X>; Tue, 16 Apr 2002 15:58:23 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:23227 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S313859AbSDPT6W>;
	Tue, 16 Apr 2002 15:58:22 -0400
Message-ID: <3CBC81DF.FC060062@hp.com>
Date: Tue, 16 Apr 2002 13:56:15 -0600
From: Khalid Aziz <khalid_aziz@hp.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Wade <lkml@bigpond.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre7
In-Reply-To: <Pine.LNX.4.21.0204160049130.18896-100000@freak.distro.conectiva> <slrnabnps8.evm.kraxel@bytesex.org> <20020416200032.14fbd436.lkml@bigpond.com> <20020416123549.A16359@bytesex.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I broke this with a typo in my patch (I inserted a line one line above
where I wanted to). Follwing patch will fix the problem.

--
Khalid

--- linux-2.4.18-hcdpold/include/asm-i386/serial.h      Tue Apr 16
12:05:27 2002
+++ linux-2.4.18-hcdp/include/asm-i386/serial.h Tue Apr 16 12:02:54 2002
@@ -140,8 +140,8 @@
 #endif
 
 #define SERIAL_PORT_DFNS               \
-       HCDP_SERIAL_PORT_DEFNS          \
        STD_SERIAL_PORT_DEFNS           \
+       HCDP_SERIAL_PORT_DEFNS          \
        EXTRA_SERIAL_PORT_DEFNS         \
        HUB6_SERIAL_PORT_DFNS           \
        MCA_SERIAL_PORT_DFNS



Gerd Knorr wrote:
> 
> > > 16 10:44:42 bogomips agetty[1111]: ttyS0: ioctl: Input/output error
> > > Apr 16 10:44:52 bogomips init: Id "S0" respawning too fast: disabled
> > > for 5 minutes
> >
> > Hi, I found that my ttyS0 had turned into ttyS1 :-) My modem was
> > unresponsive, until I changed the setting to use ttyS1, hope this helps.
> 
> Making getty using ttyS1 works for me too, I have my login prompt back.
> Looks like a off-by-one bug ...
> 
>   Gerd
> 
> --
> #include </dev/tty>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

====================================================================
Khalid Aziz                              Linux Systems Operation R&D
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
