Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130416AbQKCWRD>; Fri, 3 Nov 2000 17:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131462AbQKCWQx>; Fri, 3 Nov 2000 17:16:53 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:7428 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S130416AbQKCWQh>;
	Fri, 3 Nov 2000 17:16:37 -0500
Date: Fri, 3 Nov 2000 15:15:46 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Thomas Kotzian <thomas.kotzian@gmx.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling 2.4.0-test10 on PPC
Message-ID: <20001103151546.B15803@hq.fsmlabs.com>
In-Reply-To: <001a01c045de$94695080$0301a8c0@home000.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <001a01c045de$94695080$0301a8c0@home000.net>; from Thomas Kotzian on Fri, Nov 03, 2000 at 10:39:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

} 2.4.0-test10 doesn't compile correctly on a mac.
} Only 2 changes are necessary to make it work.
} Or are there any bigger problems with the ppc arch?
} 
} the 2 changes:
} in ./include/asm-ppc/param.h the following lines have to be added
} right before the last #endif:
} 
} #ifdef __KERNEL__
} # define CLOCKS_PER_SEC 100 /* frequency at which times() counts */
} #endif
} 
} in ./drivers/input/keybdev.c the second #elif (CONFIG_ADB) or
} something like that should be changed to #else or the correct #elif
} statement.
} 
} I don't know who's the maintainer of the ppc arch - i think ibm has
} taken it over or am i wrong about that?

No, that's not right :)

Grab the latest ppc tree from www.fsmlabs.com/linuxppcbk.html.  The fixes
are there and the main kernel.org tree will be brought up to speed.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
