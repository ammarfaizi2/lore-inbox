Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbVIVWCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbVIVWCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 18:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbVIVWCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 18:02:43 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:17312 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751302AbVIVWCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 18:02:42 -0400
Subject: RE: ip_contrack refuses to load if built UP as a module on IA64
From: dann frazier <dannf@hp.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-ia64@vger.kernel.org, tony.luck@intel.com, dmosberger@gmail.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <17174.35525.283392.703723@berry.gelato.unsw.EDU.AU>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0443A5FA@scsmsx401.amr.corp.intel.com>
	 <ed5aea430508301229386fc596@mail.gmail.com>
	 <17172.54563.329758.846131@wombat.chubb.wattle.id.au>
	 <17174.35525.283392.703723@berry.gelato.unsw.EDU.AU>
Content-Type: text/plain
Date: Thu, 22 Sep 2005 16:04:59 -0600
Message-Id: <1127426700.25159.63.camel@krebs.dannf>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-01 at 14:59 +1000, Peter Chubb wrote:
> 
> This patch makes UP and SMP do the same thing as far as module per-cpu
> data go.
> 
> Unfortunately it affects core code.

It causes 2.6.13/x86 to fail to link:
kernel/built-in.o: In function `load_module':
: undefined reference to `percpu_modcopy'
make: *** [.tmp_vmlinux1] Error 1

fyi, this is a problem we're seeing in the Debian UP packages:
  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=325070

