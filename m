Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266887AbUGVSBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266887AbUGVSBG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 14:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266869AbUGVR7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 13:59:22 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:35796 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266872AbUGVR6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 13:58:32 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Pat Gefre <pfg@sgi.com>
Subject: Re: Altix I/O code re-org
Date: Thu, 22 Jul 2004 13:57:53 -0400
User-Agent: KMail/1.6.2
Cc: linux-ia64@vger.kernel.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
References: <200407221514.i6MFEVag084696@fsgi900.americas.sgi.com>
In-Reply-To: <200407221514.i6MFEVag084696@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407221357.53404.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 22, 2004 11:14 am, Pat Gefre wrote:
> We have redone the I/O layer in the Altix code.
>
> We are posting this code for review before submitting for
> inclusion in the 2.5 tree.
>
> The code can be seen at:
> ftp://oss.sgi.com/projects/sn2/sn2-update/
>
> The general changes are:
> o added new hardware support
> o ran all code thru Lindent
> o code cleanup (typedefs, include files, etc.)
> o simplified the directory structure (all files under arch/ia64/sn/io/
>   are deleted, new files are under arch/ia64/sn/ioif/)
> o code size reduced by >50%
> o major reorg of the code itself
> o copyright updates

One of the most important changes this patch makes is to rip out all of the 
SGI PCI probing code.  Our PROM now probes for I/O devices and tells the 
kernel where they are (similar to the ACPI model, which we may get to 
eventually).  The result is much more readable code with less duplication.  
Please take a look and let us know if you have any feedback, since we'd like 
to get this in as soon as we release a PROM that supports probing.

Thanks,
Jesse
