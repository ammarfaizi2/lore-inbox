Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269578AbUJEPpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269578AbUJEPpN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269657AbUJEPpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:45:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24772 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269570AbUJEPnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:43:53 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
Date: Tue, 5 Oct 2004 08:43:44 -0700
User-Agent: KMail/1.7
Cc: "Pat Gefre" <pfg@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C647@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0221C647@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410050843.44265.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 4, 2004 10:13 pm, Luck, Tony wrote:
> I'm ok with the delete/add of most of the SGI
> specific files (maybe it still isn't perfect yet,
> but it may be close enough to take it, and then
> clean up with some small patches).
>
> But you seem to be touching some files outside of pure SGI
> stuff.  These two are a bit of a concern:
>
>   include/asm-ia64/io.h

Not sure about these changes...

>   arch/ia64/pci/pci.c

It looks like the only non-codingstyle change here is to make pci_root_ops 
non-static (and btw, some of the CodingStyle fixups look wrong).  If it needs 
to be non-static, it should be declared in a header file so we don't have to 
extern it in sn_pci_fixup_bus.

Jesse
