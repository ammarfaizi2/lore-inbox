Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266335AbUFYNjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266335AbUFYNjZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 09:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266358AbUFYNjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 09:39:24 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:9024 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266335AbUFYNjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 09:39:21 -0400
Date: Fri, 25 Jun 2004 14:39:25 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@localhost.localdomain
To: David van Hoose <david.vanhoose@comcast.net>
cc: "Philip R. Auld" <pauld@egenera.com>,
       Christoph Hellwig <hch@infradead.org>,
       Helge Hafting <helge.hafting@hist.no>, <linux-kernel@vger.kernel.org>
Subject: Re: Collapse ext2 and 3 please
In-Reply-To: <40DC2063.7070109@comcast.net>
Message-ID: <Pine.LNX.4.44.0406251438420.15676-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# gzip -dc /boot/initrd-2.4.21-15.EL.img | file -
standard input:              Linux rev 1.0 ext2 filesystem data

Make sure you use the correct filename for your initrd image (check 
/etc/grub.conf to find out which one is used).

Kind regards
Tigran

On Fri, 25 Jun 2004, David van Hoose wrote:

> That could be a problem. How do I check its configuration?
> 
> Regards,
> David
> 
> Philip R. Auld wrote:
> > Rumor has it that on Fri, Jun 25, 2004 at 07:50:42AM -0400 David van Hoose said:
> > 
> >>yeah.. Really. Here's what I do.
> >>
> >>I have ext3 partitions, so I decided if they are different partitions, 
> >>then I can compile my kernel with ext2 as a module and ext3 builtin.
> >>So I do it and reboot. Panic! Reason? Cannot find filesystem for the 
> >>root partition.
> >>The error is in the kernel itself either way. Pick your reason.
> >>1) ext3 is identified as ext2 on bootup.
> >>2) There is no fallback to ext3 if ext2 is not found.
> >>
> >>I'll check this again to be sure on a 2.6 kernel later today, but as far 
> >>as 2.4 is concerned my kernel panics.
> >>
> > 
> > 
> > 
> > Make sure any initrd you are using is not ext2 based.
> > 
> > Cheers,
> > 
> > Phil
> > 
> > 
> > 
> >>Regards,
> >>David
> >>
> >>PS. Shut up with the cheap insults. I have empirical evidence supporting 
> >>my claim. Meaning there exists a bug somewhere.
> >>
> >>Christoph Hellwig wrote:
> >>
> >>>On Fri, Jun 25, 2004 at 07:30:40AM -0400, David van Hoose wrote:
> >>>
> >>>
> >>>>If ext2 and ext3 are different filesystems, why does my kernel panic if 
> >>>>I include ext3 in the kernel make ext2 a module?
> >>>
> >>>
> >>>My kernel doesn't, must be a problem in front of the computer.
> >>>
> >>>
> >>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

