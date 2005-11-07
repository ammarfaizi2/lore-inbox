Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbVKGS43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbVKGS43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbVKGS43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:56:29 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:41387 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964928AbVKGS42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:56:28 -0500
Date: Mon, 7 Nov 2005 12:56:21 -0600
To: Greg KH <greg@kroah.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: typedefs and structs [was Re: [PATCH 16/42]: PCI:  PCI Error reporting callbacks]
Message-ID: <20051107185621.GD19593@austin.ibm.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005035.GA26929@mail.gnucash.org> <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107182727.GD18861@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 10:27:27AM -0800, Greg KH was heard to remark:
> 
> 3) realy strong typing that sparse can detect.

Am compiling now.

> enums don't really work, as you can get away with using an integer and
> the compiler will never complain.  Please use a typedef (yeah, I said
> typedef) in the way that sparse will catch any bad users of the code.

How about typedef'ing  structs?

I'm not to clear on what "sparse" can do; however, in the good old days,
gcc allowed you to commit great sins when passing "struct blah *" to 
subroutines, whereas it stoped you cold if you tried the same trick 
with a typedef'ed "blah_t *".  This got me into the habit of turning
all structs into typedefs in my personal projects.  Can we expect
something similar for the kernel, and in particular, should we start
typedefing structs now?

(Documentation/CodingStyle doesn't mention typedef at all).

--linas

