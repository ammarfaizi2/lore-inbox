Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVBOTgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVBOTgw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVBOTe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:34:58 -0500
Received: from nevyn.them.org ([66.93.172.17]:29826 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261832AbVBOTd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:33:27 -0500
Date: Tue, 15 Feb 2005 14:33:04 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, paulus@samba.org, anton@samba.org,
       davem@davemloft.net, ralf@linux-mips.org, tony.luck@intel.com,
       ak@suse.de, willy@debian.org, schwidefsky@de.ibm.com
Subject: Re: [PATCH] Consolidate compat_sys_waitid
Message-ID: <20050215193304.GA1175@nevyn.them.org>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>, paulus@samba.org,
	anton@samba.org, davem@davemloft.net, ralf@linux-mips.org,
	tony.luck@intel.com, ak@suse.de, willy@debian.org,
	schwidefsky@de.ibm.com
References: <20050215140149.0b06c96b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215140149.0b06c96b.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 02:01:49PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> This patch does:
> 	- consolidate the three implementations of compat_sys_waitid
> 	  (some were called sys32_waitid).
> 	- adds sys_waitid syscall to ppc
> 	- adds sys_waitid and compat_sys_waitid syscalls to ppc64
> 
> Parisc seemed to assume th existance of compat_sys_waitid.  The MIPS
> syscall tables have me confused and may need updating.  I have arbitrarily
> chosen the next available syscall number on ppc and ppc64, I hope this is
> correct.

I posted a (not-consolidated) sys32_waitid to the MIPS list on Sunday.
The syscall tables should confuse you :-)  N32 needs to use compat
versions of most structures, but not siginfo_t.  O32 needs to use
compat versions of everything.  Your new version can replace the
sys32_waitid from my patch, but not sysn32_waitid.

Ralf, I'll let you sort it out :-)

-- 
Daniel Jacobowitz
CodeSourcery, LLC
