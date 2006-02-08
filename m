Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965180AbWBHVij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbWBHVij (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWBHVij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:38:39 -0500
Received: from fmr23.intel.com ([143.183.121.15]:48294 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S965154AbWBHVih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:38:37 -0500
Message-Id: <200602082136.k18LaXg20942@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Matthew Wilcox'" <matthew@wil.cx>
Cc: "'Jes Sorensen'" <jes@sgi.com>, "Alex Williamson" <alex.williamson@hp.com>,
       "Luck, Tony" <tony.luck@intel.com>, "Adrian Bunk" <bunk@stusta.de>,
       "Keith Owens" <kaos@sgi.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [2.6 patch] let IA64_GENERIC select more stuff
Date: Wed, 8 Feb 2006 13:36:33 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYs9j4HgFOjlONkR5qlA1Ka/kstyQAAMswA
In-Reply-To: <20060208212416.GA1593@parisc-linux.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote on Wednesday, February 08, 2006 1:24 PM
> On Wed, Feb 08, 2006 at 11:55:58AM -0800, Chen, Kenneth W wrote:
> > CONFIG_IA64_GENERIC select CONFIG_ACPI, and CONFIG_ACPI select CONFIG_PCI,
> > This whole thread is silly since the beginning and it is a moot point for
> > all of previous discussions.  What are we talking about exactly??
> 
> I think the problem is that ia64 is abusing the 'select' feature.
> Select is a reverse dependency.  It should be used to turn things on
> which are required for this option to work.  Right now, the generic
> config uses it to turn on things which people think you probably want
> if you're building a generic kernel.
> 
> IMO, the select statements should be deleted.  They make it impossible to
> build a generic kernel without ACPI or NUMA.  While both are ubiquitous
> in ia64 implementations, they really aren't mandatory.

Things are mangled so badly that you can't even compile a generic kernel
after deselecting ACPI.

