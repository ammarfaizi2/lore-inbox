Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264814AbUDWOEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264814AbUDWOEx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 10:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264816AbUDWOEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 10:04:52 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:38094 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264814AbUDWODn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 10:03:43 -0400
Date: Fri, 23 Apr 2004 15:03:41 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [OFFTOPIC] 2.6.4v SFS instead of NTFS mp
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01E2576A@mesadm.epl.prov-liege.be>
Message-ID: <Pine.SOL.4.58.0404231459370.15680@yellow.csi.cam.ac.uk>
References: <D9B4591FDBACD411B01E00508BB33C1B01E2576A@mesadm.epl.prov-liege.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2004, Frederick, Fabian wrote:
> Anton,
>
> 	Working with the following config
>
> 	hda : dos partitioning
> 	hdb : ldm
>
> 	When plugging LDM in both 2.6.4 & 2.6.5 I have VFS unable to mount
> the /dev/hda7 original root device.
> (This won't happen just before building both kernels without that support
> ...)
>
> If I diff configs with/out advanced partition selection:
>
> Without :
> CONFIG_MSDOS_PARTITION=y
> With:
> -CONFIG_MSDOS_PARTITION=y
> +CONFIG_PARTITION_ADVANCED=y
>
> Does it mean I can't work in hybrid mode ?

Weird.  The output seems to suggest that your .config is wrong.  You want
the following in there:

CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_LDM_PARTITION=y

I suggest you run make menuconfig and make sure that you have actually
selected support for both MSDOS and LDM partitions...  Or edit your
.config and make sure you have the above three lines and then run make
oldconfig...

Let me know if that still gives you problems.  It shouldn't!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
