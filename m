Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVCWWGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVCWWGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 17:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbVCWWGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 17:06:36 -0500
Received: from ozlabs.org ([203.10.76.45]:42949 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261436AbVCWWGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 17:06:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16961.59549.946004.551974@cargo.ozlabs.ibm.com>
Date: Thu, 24 Mar 2005 09:07:25 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Hugh Dickins" <hugh@veritas.com>, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       <akpm@osdl.org>, <davem@davemloft.net>, <benh@kernel.crashing.org>,
       <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/6] freepgt: free_pgtables use vma list
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0324516D@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0324516D@scsmsx401.amr.corp.intel.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony writes:

> Can we legislate that "end==0" isn't possible.

I think this is only likely to be a problem on 32-bit platforms with
hardware support for separate user and kernel address spaces.  m68k
and sparc32 come to mind, though I might be mistaken.

Paul.
