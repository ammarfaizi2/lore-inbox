Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135738AbRAJRH3>; Wed, 10 Jan 2001 12:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135739AbRAJRHT>; Wed, 10 Jan 2001 12:07:19 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:44806 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S135738AbRAJRHI>; Wed, 10 Jan 2001 12:07:08 -0500
Message-ID: <3A5C96BB.96B19DB@Hell.WH8.TU-Dresden.De>
Date: Wed, 10 Jan 2001 18:07:07 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre1 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
In-Reply-To: <3A5C6417.6670FCB7@Hell.WH8.TU-Dresden.De> <20010110181516.X10035@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ingo Oeser wrote:
> 
> The only thing that looks responsible for this is the FXSR stuff,
> that changed.
> 
> Like to try again backing this out?

Just to make sure it wasn't a gcc thing, I've recompiled the original
setup with egcs-1.1.2 (previously had used 2.95.2) and that did not
fix a thing.

Next backed out the entire XMM and FXSR related stuff and now everything
is fine again. The CPU in question is an AMD Thunderbird (see cpuinfo
below). A friend with a similar setup but a Pentium-3 CPU doesn't seem
to see the problem (couldn't verify myself).

/proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 807.211
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1608.90 


Who wrote that new FXSR stuff? Maybe they have an idea of what's going on.

Regards,
Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
