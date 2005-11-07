Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbVKGTEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbVKGTEh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 14:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVKGTEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 14:04:37 -0500
Received: from xenotime.net ([66.160.160.81]:56736 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964990AbVKGTEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 14:04:36 -0500
Date: Mon, 7 Nov 2005 11:04:29 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: linas <linas@austin.ibm.com>
cc: Greg KH <greg@kroah.com>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, johnrose@austin.ibm.com,
       linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: typedefs and structs [was Re: [PATCH 16/42]: PCI:  PCI Error
 reporting callbacks]
In-Reply-To: <20051107185621.GD19593@austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0511071059320.8922@shark.he.net>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005035.GA26929@mail.gnucash.org>
 <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com>
 <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com>
 <20051107185621.GD19593@austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, linas wrote:

> On Mon, Nov 07, 2005 at 10:27:27AM -0800, Greg KH was heard to remark:
> >
> > 3) realy strong typing that sparse can detect.
>
> Am compiling now.
>
> > enums don't really work, as you can get away with using an integer and
> > the compiler will never complain.  Please use a typedef (yeah, I said
> > typedef) in the way that sparse will catch any bad users of the code.
>
> How about typedef'ing  structs?

No no no.  (I feel sure that you will get plenty of responses.)

> I'm not to clear on what "sparse" can do; however, in the good old days,
> gcc allowed you to commit great sins when passing "struct blah *" to
> subroutines, whereas it stoped you cold if you tried the same trick
> with a typedef'ed "blah_t *".  This got me into the habit of turning
> all structs into typedefs in my personal projects.  Can we expect
> something similar for the kernel, and in particular, should we start
> typedefing structs now?

No no no.

> (Documentation/CodingStyle doesn't mention typedef at all).

We can submit patches for that.

Basically (generally) we never want a struct to be typedef-ed.
(There may be a couple of exceptions to this.)

We do allow a very few basic types to be typedef-ed, as long as
the basic type (e.g., pid_t) is also a C language basic type or
the typedef is useful for strong type checking.

-- 
~Randy
