Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbUAMP2t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 10:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbUAMP2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 10:28:49 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:63669 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S264290AbUAMP2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 10:28:48 -0500
Subject: RE: [ACPI] [PATCH] 2.4/2.6 use xdsdt to print table header
From: Alex Williamson <alex.williamson@hp.com>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, "Brown, Len" <len.brown@intel.com>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CC2@PDSMSX403.ccr.corp.intel.com>
References: <3ACA40606221794F80A5670F0AF15F8401720CC2@PDSMSX403.ccr.corp.intel.com>
Content-Type: text/plain
Message-Id: <1074007725.6494.11.camel@patsy.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 13 Jan 2004 08:28:46 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-13 at 00:38, Yu, Luming wrote:
> >    I'm resending this patch to get it into the main ACPI source.  This
> > fixes a problem where the DSDT pointer in the FADT is NULL because it
> > uses the 64bit XDSDT instead.  The current code is happy to map a NULL
> > address and return success to the caller.  This can crash the 
> > system or
> > printout garbage headers to the console.  It's a simple 
> > matter to check
> > table revision and use the XDSDT in favor of the DSDT.  This has been
> > living happily in both the 2.4 and 2.6 ia64 tree for some 
> > time.  Please
> > accept.  Thanks,
> 
> I just checked with http://lia64.bkbits.net:8080/linux-ia64-2.4 .
> The patch has been merged. Please take a look at

   Right, it's in the ia64 trees, but understandably the ia64 arch
maintainers don't want to carry this non-ia64 specific patch
indefinitely.  This is a generic ACPI issue for an system that chooses
to use the xdsdt in place of the dsdt.  It should be included in the
ACPI tree and pushed up from there.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

