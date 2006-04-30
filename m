Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWD3FTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWD3FTL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 01:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWD3FTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 01:19:11 -0400
Received: from smtpout.mac.com ([17.250.248.184]:40391 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750959AbWD3FTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 01:19:10 -0400
In-Reply-To: <20060429215501.GA9870@kroah.com>
References: <20060428112225.418cadd9.holzheu@de.ibm.com> <20060429075311.GB1886@kroah.com> <8A7D2F4D-5A05-4C93-B514-03268CAA9201@mac.com> <20060429215501.GA9870@kroah.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4237705F-E1B2-46CF-BE66-EFB77F68EC42@mac.com>
Cc: Michael Holzheu <holzheu@de.ibm.com>, akpm@osdl.org,
       schwidefsky@de.ibm.com, penberg@cs.helsinki.fi, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] s390: Hypervisor File System
Date: Sun, 30 Apr 2006 01:18:46 -0400
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 29, 2006, at 17:55:01, Greg KH wrote:
> relayfs is for that.  You can now put relayfs files in any ram  
> based file system (procfs, ramfs, sysfs, debugfs, etc.)

But you can't twiddle relayfs with echo and cat; it's more suited to  
high-bandwidth transfers than anything else, no?  The idea here would  
be to be able to interact with the files in /sys the same way you  
always do, but provide a sort of consistency system whereby a program  
_or_ sysadmin can attach its view of the /sys/hypervisor directory  
tree to a particular snapshot of the system.  As far as I can tell  
(although I'd be happy to be proven wrong), there is no trivial way  
to manually access or shellscript relayfs files, the way you can  
"cat /sys/devices/<path-to-device>/dev".

Cheers,
Kyle Moffett
