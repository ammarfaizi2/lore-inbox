Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130225AbQL0Ls0>; Wed, 27 Dec 2000 06:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130109AbQL0LsQ>; Wed, 27 Dec 2000 06:48:16 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:16484 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S130225AbQL0LsB>;
	Wed, 27 Dec 2000 06:48:01 -0500
Message-ID: <3A49CF1C.19A0FB55@student.ethz.ch>
Date: Wed, 27 Dec 2000 12:14:36 +0100
From: "Giacomo A. Catenazzi" <cate@student.ethz.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
CC: linux-kernel@vger.kernel.org, linux-kbuild@torque.net
Subject: Re: [KBUILD] How do we handle autoconfiguration?
In-Reply-To: <200012262313.eBQNDBi07719@snark.thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Dec 2000 11:17:33.0977 (UTC) FILETIME=[9C359890:01C06FF6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> I backed away from this because Giacomo Catenazzi told me he was
> working on a separate autoconfigurator that would generate config
> files in CML1 format.  That's a cleaner design -- one would run his
> autoconfigurator and then import the resulting config into the CML2
> configurator as frozen (immutable) symbols.  Giacomo, what's the state
> of your project?

Status:
Now I can detect most of modern hardware, and also some software
protocols.
My autoconfiguration only in few case say N, because is it difficult
to say: you don't need this drivers (e.g. the Matrox Millemium
include a list of PCI devices, but my card is not included,
but anyway, the driver works, because after the check of PCI ID, it
do further checks on other video PCI class).

I'm happy with the autodetection. I need some other software protocols
to detect, but it is difficult to distinguish: "need protocols" and
"protocols included in actual kernel (but nobody will use it)".


I've difficult to merge with the CML1/2:

In CML2-0.8.3 the include frozen flag (-I) is broken, and
also the new -W flag is broken, thus no real test.

CML2-0.9.0 need Python 2, which is not in the debian unstable
distribution, and I had no time to compile myself.

CML1: There is to many not answered question (most not important)
thus it has little value in use with make oldconfig.
(CML2 has a "oldmenuconfig and oldxconfig")
Thus I should modify the Configure files, but with CML2....


I will also add a NOVICE/NORMAL/EXPERT configuration menu,
to include ELF, COFF, IPC, SHM, ...  . It is in project since
lots of days, but ELM, COFF, ELF64 are processor dependent,
and I don't find (yet) a clean method to include this
dependence (CML2).


	giacomo


TODO: a correct/complete autodetection of CPU.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
