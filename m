Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269855AbUIDJnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269855AbUIDJnv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 05:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269857AbUIDJnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 05:43:50 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:38571 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269855AbUIDJnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 05:43:40 -0400
Date: Sat, 4 Sep 2004 10:43:39 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Christoph Hellwig <hch@infradead.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sf.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
In-Reply-To: <20040904102914.B13149@infradead.org>
Message-ID: <Pine.LNX.4.58.0409041031370.25475@skynet>
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com>
 <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Umm, the Linux kernel isn't about minimizing interfaces.  We don't link a
> copy of scsi helpers into each scsi driver either, or libata into each sata
> driver.

true but the DRM isn't only about the Linux kernel, the DRM is a lowlevel
component of a much larger system, of which the DRM just has to reside in
the kernel,

While I agree the perfcet solution is to introduce another binary
interface, but no-one on the dri-devel list is willing to dedicate most of
their time for the next age answering questions like "well I upgraded my
r200 driver, and my mga stopped working, and the ATI binary driver killed
my dog when I changed something else", Ian has pointed this out on the
dri-devel list as a major issue and to be honest he is not alone in his
worries, if make the kernel responsible for the registration/de-reg only
then build everything else in the drivers, we don't have to worry about
someone adding a line to the middle of a structure and breaking the
modules from somewhere else.. not many people have two different graphics
cards and I'd rather inconvience them than increase support burden..

We go through this with the DRI/DRM/DDX interfaces on a number of
occasions.. also the debacle of the i810 interface changes way back when..
I'd rather avoid it all at this stage.. again we are trying to find an
agreeable balancing point...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

