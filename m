Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVHXUTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVHXUTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 16:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVHXUTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 16:19:50 -0400
Received: from fmr13.intel.com ([192.55.52.67]:53143 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932093AbVHXUTs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 16:19:48 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 05/15] ia64: remove use of asm/segment.h
Date: Wed, 24 Aug 2005 13:19:38 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F043851AD@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 05/15] ia64: remove use of asm/segment.h
Thread-Index: AcWo59Ug7OXCApGjSACcD+cxvEUogQAADf7g
From: "Luck, Tony" <tony.luck@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, "Kumar Gala" <galak@freescale.com>
Cc: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 24 Aug 2005 20:19:40.0110 (UTC) FILETIME=[27F45EE0:01C5A8E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>There are still a few drivers that include asm/segment.h, so
>I don't think we should remove asm/segment.h itself just yet.

Agreed.  The sequence should be to send patches to get rid of
all "#include <asm/segment.h>" references.

Once they have all gone, then a patch can remove the files.

If you are concerned that people would start adding new
references and you don't want to get into a game of whack-a-mole,
then you could add #warning "include of deprecated asm/segment.h",
but that might be overkill.

I'll apply this for ia64 w/o the deletion.

-Tony
