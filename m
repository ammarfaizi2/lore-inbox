Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287208AbSAZWoL>; Sat, 26 Jan 2002 17:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287212AbSAZWoB>; Sat, 26 Jan 2002 17:44:01 -0500
Received: from ns.suse.de ([213.95.15.193]:32775 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287208AbSAZWns>;
	Sat, 26 Jan 2002 17:43:48 -0500
To: "Martin Eriksson" <nitrax@giron.wox.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
In-Reply-To: <200201251550.g0PFoIPa002738@tigger.cs.uni-dortmund.de.suse.lists.linux.kernel> <200201250802.32508.bodnar42@phalynx.dhs.org.suse.lists.linux.kernel> <jeelkes8y5.fsf@sykes.suse.de.suse.lists.linux.kernel> <a2sv2s$ge3$1@penguin.transmeta.com.suse.lists.linux.kernel> <20020126034106.F5730@kushida.apsleyroad.org.suse.lists.linux.kernel> <012d01c1a687$faa11120$0201a8c0@HOMER.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 26 Jan 2002 23:43:42 +0100
In-Reply-To: "Martin Eriksson"'s message of "26 Jan 2002 17:43:03 +0100"
Message-ID: <p737kq420o1.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin Eriksson" <nitrax@giron.wox.org> writes:

> -CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
> +CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -Os \
>           -fomit-frame-pointer -fno-strict-aliasing -fno-common
>  AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)

You should remove the -malign-* options in arch/i386/Makefile too.
Most of -Os win normally comes from doing less aggressive padding,
but the kernel overrides this.

Also gcc 3.0 and gcc 3.1-snapshots should be somewhat better at 
implementing -Os. 

-Andi
