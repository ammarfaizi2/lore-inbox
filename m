Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268946AbTBWUNf>; Sun, 23 Feb 2003 15:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268954AbTBWUNf>; Sun, 23 Feb 2003 15:13:35 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:10379 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268946AbTBWUNb>; Sun, 23 Feb 2003 15:13:31 -0500
Date: Sun, 23 Feb 2003 12:24:01 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug with (maybe not *in*) sysfs
Message-ID: <20030223202401.GA1452@beaverton.ibm.com>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <5480000.1046028715@[10.10.2.4]> <Pine.LNX.4.33.0302231310500.923-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302231310500.923-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel [mochel@osdl.org] wrote:
> 
> This is typically caused by the same object being added twice at the same 
> level in the hierarchy, which appears to be happening. Is the ips driver 
> calling pci_register_driver() twice? 
> 
> 	-pat

It was possible in the past that pci_module_init could be called more
than once with non-unique pci_driver names. It is fixed in the current
trees, but I do not have the date when it was pushed. Here is some
context mail links.

http://marc.theaimsgroup.com/?l=linux-scsi&m=104275858704733&w=2

http://marc.theaimsgroup.com/?l=linux-scsi&m=104455557710731&w=2

-andmike
--
Michael Anderson
andmike@us.ibm.com

