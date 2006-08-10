Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWHJISU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWHJISU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 04:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWHJIST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 04:18:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:54545 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751466AbWHJISR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 04:18:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qSv4auiOrD/P1nZLwoQHxG4YRVrfi1yGVh1FLdtrQnn7NBz4ETIiLtW7MZ0cA2Wu7+Ri7KQy6Pc5Dpj0DW7WHfl9DTSIEwGE/EcdWYTKXe7eqwjB5CABVN8xsdaAUE1ApasoU78MZ45TAiO87MfF874zGEhhh1WzVFVu4lAdpnY=
Message-ID: <292693080608100118rc910647l7a8bf95fbc2df26c@mail.gmail.com>
Date: Thu, 10 Aug 2006 13:48:14 +0530
From: "Daniel Rodrick" <daniel.rodrick@gmail.com>
To: "Alan Shieh" <ashieh@cs.cornell.edu>
Subject: Re: Univeral Protocol Driver (using UNDI) in Linux
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       "Linux Newbie" <linux-newbie@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44D8A80F.1020202@cs.cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <292693080608070339p6b42feacw9d8f27a147cf1771@mail.gmail.com>
	 <44D7579D.1040303@zytor.com>
	 <292693080608070911g57ae1215qd994e03b9dd87b66@mail.gmail.com>
	 <44D76F26.9@zytor.com>
	 <292693080608072213n2be75176g46199e92d669f5de@mail.gmail.com>
	 <44D8A80F.1020202@cs.cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

First things first. Tons of thanks for a mail FULLY LOADED with useful
information. I'm still to digest it all, but really thanks.


> >> >
> >> > I'm sure having a single driver for all the NICs is a feature cool
> >> > enough to die for. Yes, it might have drawbacks like just pointed out
> >> > by Peter, but surely a "single driver for all NIC" feature could prove
> >> > to be great in some systems.
> >> >
[Snip]
> >
> > Hi ... so there seem to be no technical feasibily issues, just
> > reliabliy / ugly design issues? So one can still go ahead and write a
> > Universal Protocol Driver that can work with all (PXE compatible)
> > NICs?
>
> With help from the Etherboot Project, I've recently implemented such a
> driver for Etherboot 5.4. It currently supports PIO NICs (e.g. cards
> that use in*/out* to interface with CPU). It's currently available in a
> branch, and will be merged into the trunk by the Etherboot project. It
> works reliably with QEMU + PXELINUX, with the virtual ne2k-pci NIC.

Umm ... pardon me if I am wrong, but I think you implemented a "UNDI
Driver" (i.e. the code that provides implementation of UNDI API, and
often resides in the NIC ROM) . I'm looking forward to write a
"Universal Protocol Driver" (i.e. the code that will be a linux kernel
module and will, use the UNDI API provided by your UNDI driver).

But nevertheless your information has been *VERY* helpful ...

> At minimum, one needs to be able to probe for !PXE presence, which means
> you need to map in 0-1MB of physical memory. The PXE stack's memory also
> needs to be mapped in. My UNDI driver relies on a kernel module, generic
> across all NICs, to accomplish these by mapping in the !PXE probe area
> and PXE memory in a user process.

I'm pretty newbie to PXE, but I I think !PXE structure is used to find
out the location & size of PXE & UNDI runtime routines, by UNIVERSAL
PROTOCOL DRIVERS. Is my understanding wrong?

Also, I think that UNDI driver routine will need not call PXE routines
(TFTP / DHCP etc) as UNDI routines would be at a lower level providing
access to the bare bones hardware. Is this correct?

Thanks,

Dan
