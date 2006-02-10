Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWBJKD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWBJKD4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 05:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWBJKD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 05:03:56 -0500
Received: from ns.suse.de ([195.135.220.2]:10375 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751213AbWBJKD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 05:03:56 -0500
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Date: Fri, 10 Feb 2006 11:02:24 +0100
User-Agent: KMail/1.8.2
Cc: Ashok Raj <ashok.raj@intel.com>, ntl@pobox.com, dada1@cosmosbay.com,
       riel@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       mingo@elte.hu, 76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, pj@sgi.com
References: <20060209160808.GL18730@localhost.localdomain> <20060209090321.A9380@unix-os.sc.intel.com> <20060209100429.03f0b1c3.akpm@osdl.org>
In-Reply-To: <20060209100429.03f0b1c3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101102.25437.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 February 2006 19:04, Andrew Morton wrote:
> Ashok Raj <ashok.raj@intel.com> wrote:
> >
> > The problem was with ACPI just simply looking at the namespace doesnt
> >  exactly give us an idea of how many processors are possible in this platform.
> 
> We need to fix this asap - the performance penalty for HOTPLUG_CPU=y,
> NR_CPUS=lots will be appreciable.

What is this performance penalty exactly? 

It wastes quite some memory (each possible CPU needs 32K of memory which
adds quickly up), but it shouldn't impact other CPU use. 

> 
> Do any x86 platforms actually support CPU hotplug?

Xen does.  And it's needed for suspend/resume on normal x86 now.

-Andi

 
