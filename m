Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbSKTTaI>; Wed, 20 Nov 2002 14:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbSKTT3L>; Wed, 20 Nov 2002 14:29:11 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:50646 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S262790AbSKTT3C>;
	Wed, 20 Nov 2002 14:29:02 -0500
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 20 Nov 2002 12:31:45 -0700
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Xavier Bestel <xavier.bestel@free.fr>,
       Mark Mielke <mark@mark.mielke.cc>, Rik van Riel <riel@conectiva.com.br>,
       David McIlwraith <quack@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spinlocks, the GPL, and binary-only modules
Message-ID: <20021120123145.B17249@duath.fsmlabs.com>
References: <1037801955.3241.21.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.10.10211201040330.3892-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.10.10211201040330.3892-100000@master.linux-ide.org>; from andre@linux-ide.org on Wed, Nov 20, 2002 at 10:54:30AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

} This can be made clean if all the inlined C in the headers are pushed
} back to an actual .c file and the make it function to call as an extern.
} So the solution is to make a patch and publish that patch which cleans the
} out the C code in question and move the associacted GPL license to the new
} .c files.  This is proper and legal as structs are just the glue or api.
} 
} So if I publish this patch where it can be freely available for usage by
} all, I comply with GPL.  This also removes any of the "extremists" points
} of the smallest amount of GPL code invoked by the compiler can not touch
} pure code.
} 
} Any arguments why this will not work?

Maybe something else would be better.  Adding -fno-inline to the build
might be more useful.  It makes things a bit cleaner.

It's a nasty mess to have to do this for every subsystem when someone gets
a wild-hair and starts inline-ing things without thinking.
