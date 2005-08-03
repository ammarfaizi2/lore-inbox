Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVHCHXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVHCHXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 03:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbVHCHXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 03:23:08 -0400
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:53772
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262121AbVHCHVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 03:21:32 -0400
Date: Wed, 3 Aug 2005 00:19:18 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Mark Bellon <mbellon@mvista.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH]  IDE disks show invalid geometries in /proc/ide/hd*/geometry
In-Reply-To: <42EFE547.3010206@mvista.com>
Message-ID: <Pine.LNX.4.10.10508030018390.21865-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Did you read ATA-1 through ATA-7 to understand all the variations?

On Tue, 2 Aug 2005, Mark Bellon wrote:

> The ATA specification tells large disk drives to return C/H/S data of 
> 16383/16/63 regardless of their actual size (other variations on this 
> return include 15 heads and/or 4092 cylinders). Unfortunately these CHS 
> data confuse the existing IDE code and cause it to report invalid 
> geometries in /proc when the disk runs in LBA mode.
> 
> The invalid geometries can cause failures in the partitioning tools; 
> partitioning may be impossible or illogical size limitations occur. This 
> also leads to various forms of human confusion.
> 
> I attach a patch that fixes this problem while strongly attempting to 
> not break any existing side effects and await any comments.
> 
> mark
> 
> Signed-off-by: Mark Bellon <mbellon@mvista.com>
> 
> 

