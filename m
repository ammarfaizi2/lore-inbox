Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423553AbWJZPNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423553AbWJZPNW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 11:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423555AbWJZPNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 11:13:21 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35548 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1423553AbWJZPNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 11:13:21 -0400
Date: Thu, 26 Oct 2006 11:12:41 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@muc.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Ian Campbell <Ian.Campbell@xensource.com>
Subject: Re: [PATCH] x86_64: Some vmlinux.lds.S cleanups
Message-ID: <20061026151241.GC11284@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061024210140.GB14225@in.ibm.com> <45407B05.76E4.0078.0@novell.com> <20061026134442.GA11284@in.ibm.com> <4540D9CF.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4540D9CF.76E4.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 03:52:47PM +0200, Jan Beulich wrote:
> >>> Vivek Goyal <vgoyal@in.ibm.com> 26.10.06 15:44 >>>
> >On Thu, Oct 26, 2006 at 08:08:21AM +0100, Jan Beulich wrote:
> >> I was about to ack it when I saw that you left .bss in init - that doesn't seem
> >> too good an idea... Jan
> >> 
> >
> >Should I create a separate program header say "bss" for .bss section? Last
> >time when I suggested it you said there is no need to create a separate
> >program header for bss.
> 
> No, I continue to think .bss naturally belongs at the end of the data segment.
> 

Only disadvantage of this is that .bss becomes part of the compressed data
and size of vmlinux.bin and bzImage increases.

OTOH, all the sections being mapped in segment "user" are also effectively
data only. isn't it? So .bss coming after that would make sense.

Thanks
Vivek
