Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWCODYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWCODYq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 22:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbWCODYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 22:24:46 -0500
Received: from lixom.net ([66.141.50.11]:51079 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1752071AbWCODYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 22:24:46 -0500
Date: Tue, 14 Mar 2006 21:18:13 -0600
To: Jon Mason <jdmason@us.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, Pavel Machek <pavel@suse.cz>,
       Muli Ben-Yehuda <mulix@mulix.org>, Andi Kleen <ak@suse.de>,
       Muli Ben-Yehuda <MULI@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 2/3] x86-64: Calgary IOMMU - Calgary specific bits
Message-ID: <20060315031813.GF5170@pb15.lixom.net>
References: <20060314082432.GE23631@granada.merseine.nu> <20060314082552.GF23631@granada.merseine.nu> <20060314230306.GB1579@elf.ucw.cz> <20060315005514.GD7699@us.ibm.com> <20060315005632.GE5170@pb15.lixom.net> <20060315012733.GE7699@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315012733.GE7699@us.ibm.com>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 07:27:33PM -0600, Jon Mason wrote:

> > We're killing structures like that one by one on PPC, I just haven't
> > gotten around to dealing with tce_entry yet.
> > 
> > The way to do it is to use masking and shifting by hand.
> 
> Really?  I thought this was much more elegant than masking and
> bitshifting (and less prone to errors).  Is there a particular reason to
> do it that way?

Me too, but what I've been told is that there's no guarantee for the
union/struct layouts being exactly like you (and the hardware) expects
them to be across toolchains, etc.

The endianness issues are also painful, in architecture-specific code it's
obviously not as big an issue as in generic drivers. Single-architecture
system drivers are a grey area in that aspect, but it's better to set
good examples then bad ones for the generic driver writers looking for
example code.


-Olof
