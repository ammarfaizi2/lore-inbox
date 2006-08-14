Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWHNRJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWHNRJG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWHNRJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:09:06 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:61592 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932340AbWHNRJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:09:04 -0400
Date: Mon, 14 Aug 2006 10:07:18 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: mlord@pobox.com, axboe@suse.de, sam@ravnborg.org, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: VMPLIT question
Message-ID: <20060814170718.GJ4919@us.ibm.com>
References: <20060812052744.GB4919@us.ibm.com> <1155393875.7574.88.camel@localhost.localdomain> <20060812191619.GE4919@us.ibm.com> <1155574746.7574.158.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155574746.7574.158.camel@localhost.localdomain>
X-Operating-System: Linux 2.6.17.7 (x86_64)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.2006 [09:59:06 -0700], Dave Hansen wrote:
> On Sat, 2006-08-12 at 12:16 -0700, Nishanth Aravamudan wrote:
> > > You need to ask for help with the high-level option, not the actual
> > > "choice":
> > 
> > The "high-level option" being ...?
> 
> In menuconfig, at least:
> 
> 	"Memory split (3G/1G user/kernel split)  --->"
> 
> Inside of "Processor type and features".

I think you missed the point. If you don't know that the "Memory Split"
submenu is hidden unless you enable EMBEDDED && EXPERIMENTAL and are
!X86_PAE (the latter was the problem here, until I applied your patch),
then this is not helpful. You'll do what I did, and search for VMSPLIT
in menuconfig and get the results I pasted in my first mail, which as I
said then are less than helpful.

> > What did you search for in menuconfig to get the following? And, in
> > any case, how is it useful to return a "(null)" symbol name? 
> 
> The trouble is that the help text is associated with the top-level
> "choice" Kconfig entry, not the _individual_ choices.  There is no
> symbol associated with the top-level one.  It might be useful to allow
> help text to be associated with individual "choice" entries, to
> display that text in the high-level option, and to replace the "null"
> symbol with something that says "this choice can select any of these
> symbols: FOO, BAR, etc..."

Right, I gathered as much...

> I'm sure the Kconfig folks take patches. :P

And that's what I had Roman and Sam on the Cc, as I wanted their input
if this was a worthwhile change.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
