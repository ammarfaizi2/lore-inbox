Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315379AbSGNStu>; Sun, 14 Jul 2002 14:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316679AbSGNStt>; Sun, 14 Jul 2002 14:49:49 -0400
Received: from t1o913p48.telia.com ([195.252.44.48]:37761 "EHLO
	best.localdomain") by vger.kernel.org with ESMTP id <S315379AbSGNSts>;
	Sun, 14 Jul 2002 14:49:48 -0400
To: Dominik Brodowski <devel@brodo.de>
Cc: zwane@linuxpower.ca, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac3
References: <1026611437.13885.37.camel@irongate.swansea.linux.org.uk>
	<m265zj9zxn.fsf@best.localdomain> <6010.1026651788@www53.gmx.net>
	<20020714150912.A1148@brodo.de> <m2k7nyqqud.fsf@best.localdomain>
	<20020714175025.A765@brodo.de>
From: Peter Osterlund <petero2@telia.com>
Date: 14 Jul 2002 20:52:22 +0200
In-Reply-To: <20020714175025.A765@brodo.de>
Message-ID: <m2u1n2qh09.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski <devel@brodo.de> writes:

> On Sun, Jul 14, 2002 at 05:19:54PM +0200, Peter Osterlund wrote:
> > Dominik Brodowski <devel@brodo.de> writes:
> > 
> > I tried speedstep but it didn't work because of this check in
> > speedstep_detect_processor:
> > 
> > My cpu has model == 1 and mask == 2.
> Strange: According to the Intel docs (24919923.pdf and 25072104.pdf) as of
> June 2002, all P4-Ms have models have model "2" and mask "4", and none have
> model "1" and mask "2". What does /proc/cpuinfo say? And are you really sure
> it is a speedstep-capable P4-M?
> 
> I'm really doubtful of that, as the MSR_EBC_FREQUENCY_ID didn't change a bit
> while trying speedstep transitions:

No, I think I was mistaken. The manual is for more models than the
specific one I own. Sorry about the confusion. Here is /proc/cpuinfo
anyway:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.70GHz
stepping        : 2
cpu MHz         : 1694.536
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3381.65

> How old is it? Fresh-out-of-the-factory? Then there might, just might be
> some update to the P4 specifications not yet included in the documentation.
> And please send me a /proc/cpuinfo, just to make sure. And, BTW, have you
> tried ACPI and its "performance state" interface?

I bought it about a month ago. I have only tested ACPI briefly.
Activating it in a standard 2.4 kernel doesn't work very well (battery
status not available, lots of errors in dmesg during boot.) I haven't
tested the latest patches from Intel yet.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
