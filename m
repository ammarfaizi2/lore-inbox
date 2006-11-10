Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932743AbWKJQrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743AbWKJQrK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946776AbWKJQrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:47:10 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:38069 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1946773AbWKJQrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:47:09 -0500
Message-ID: <4554AD07.4070004@us.ibm.com>
Date: Fri, 10 Nov 2006 10:47:03 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
Reply-To: maynardj@us.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC, PATCH 0/2] OProfile for Cell: Initial profiling support
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I will be posting two patches that provide the necessary changes to 
support OProfile on Cell.  These patches enable profiling of events from 
the PPU and other islands of the CBE, with the exception of the SPUs.  A 
separate patch for profiling SPUs will be posted at a future date.

The first patch is a utility header file containing macros, 
declarations, etc, used by our OProfile implementation.  It is placed in 
a "cell" subdirectory of arch/powerpc/oprofile since the planned future 
SPU patch will also be placed in this subdirectory and will #include 
this header file.  So it made sense to not clutter up the 
arch/powerpc/oprofile directory with anymore arch-specific stuff than is 
necessary.

The second patch contains the bulk of the functionality, most of which 
is in the new file, arch/powerpc/oprofile/op_model_cell.c.

These two patches rely on the patches Kevin Corry submitted to this list 
on Nov 9 (subject "Oprofile-on-Cell prereqs").

Thanks for taking the time to review these patches.

Maynard Johnson
IBM LTC Power Linux Toolchain
507-253-2650


