Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316584AbSE3LJv>; Thu, 30 May 2002 07:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316585AbSE3LJv>; Thu, 30 May 2002 07:09:51 -0400
Received: from ns.suse.de ([213.95.15.193]:35081 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316584AbSE3LJs>;
	Thu, 30 May 2002 07:09:48 -0400
Date: Thu, 30 May 2002 13:09:47 +0200
From: Dave Jones <davej@suse.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] intel-x86 model config cleanup
Message-ID: <20020530130947.J26821@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	"J.A. Magallon" <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020530021159.B26821@suse.de> <200205300243.g4U2hIZ369399@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 10:43:18PM -0400, Albert D. Cahalan wrote:
 > No, it's like this:
 > I want one kernel. I have a Pentium-MMX and a Pentium Pro.
 > I don't need support for a 386, 486, Athlon, or Xeon.
 > 
 > It's also like this:
 > 
 > We have a lab full of Athlon and Pentium III boxes.
 > There's not a Pentium 4 in sight, and no Pentium II
 > either. It's too much work to manage multiple kernels;
 > every box must boot from the same disk image.

Ok, I think I see what you're getting at. Instead of a multi-list
giving one result, you'd like to tick every box that kernel is
going run on, and have it spit out CONFIG_Mxxx for each of those
processors.

It's doable, and it keeps things like vendor kernels possible
(they just select all CPUs), it's probably quite a bit of work
though.

The trickiest bit is getting the Makefile right to choose
the lowest-chosen-denominator in the list for its gcc options, and that's
probably not that hard, just a few extra ifdefs in an already ifdef heavy area.
Other than that, dealing with the cases like "this cpu has TSC" "this
doesn't" and "this has this bug" "this doesn't have this bug" need to be
done too, but thats again, just a few more ifdefs away..

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
