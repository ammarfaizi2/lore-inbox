Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161497AbWHDVkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161497AbWHDVkt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161498AbWHDVkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:40:49 -0400
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:1447 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1161497AbWHDVks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:40:48 -0400
Date: Fri, 4 Aug 2006 17:40:39 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: David Lang <dlang@digitalinsight.com>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Antonio Vargas <windenntw@gmail.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       jeremy@xensource.com, greg@kroah.com, zach@vmware.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com
Subject: Re: A proposal - binary
Message-ID: <20060804214039.GA28508@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	David Lang <dlang@digitalinsight.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Antonio Vargas <windenntw@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
	jeremy@xensource.com, greg@kroah.com, zach@vmware.com,
	linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
	jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
	ian.pratt@xensource.com
References: <20060803225357.e9ab5de1.akpm@osdl.org> <1154675100.11382.47.camel@localhost.localdomain> <Pine.LNX.4.63.0608040944480.18902@qynat.qvtvafvgr.pbz> <69304d110608041146t44077033j9a10ae6aee19a16d@mail.gmail.com> <Pine.LNX.4.63.0608041150360.18862@qynat.qvtvafvgr.pbz> <44D39F73.8000803@linux.intel.com> <Pine.LNX.4.63.0608041239430.18862@qynat.qvtvafvgr.pbz> <44D3A9F3.2000000@goop.org> <Pine.LNX.4.63.0608041325280.18862@qynat.qvtvafvgr.pbz> <44D3BB7C.4000001@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D3BB7C.4000001@goop.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 02:26:20PM -0700, Jeremy Fitzhardinge wrote:
> >I also am missing something here. how can a system be compiled to do 
> >several different things for the same privilaged opcode (including 
> >running that opcode) without turning that area of code into a 
> >performance pig as it checks for each possible hypervisor being present?
> 
> Conceptually, the paravirtops structure is a structure of pointers to 
> functions which get filled in at runtime to support whatever hypervisor 
> we're running over.  But it also has the means to patch inline versions 
> of the appropriate code sequences for performance-critical operations.

Perhaps Ulrich and Jakub should join this discussion, as the whole
thing sounds like a rehash of the userland ld.so + glibc versioned ABI.
glibc has weathered 64-bit LFS changes to open(), SYSENTER, and vdso.

Isn't this discussion entirely analogous (except for the patching of
performance critical sections, perhaps) to taking a binary compiled
against glibc-2.0 back on Linux-2.2 and running it on glibc-2.4 + 2.6.17?
Or OpenSolaris, for that matter?

	Bill Rugolsky
