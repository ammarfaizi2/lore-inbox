Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263102AbVCKCeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbVCKCeX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbVCKCeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:34:23 -0500
Received: from ozlabs.org ([203.10.76.45]:64228 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263102AbVCKCeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:34:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.948.350317.549743@cargo.ozlabs.ibm.com>
Date: Fri, 11 Mar 2005 13:34:28 +1100
From: Paul Mackerras <paulus@samba.org>
To: Ingo Oeser <ioe-lkml@axxeo.de>
Cc: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Allow emulation of mfpvr on ppc64 kernel
In-Reply-To: <200503102317.04027.ioe-lkml@axxeo.de>
References: <20050310021848.GD30435@localhost.localdomain>
	<200503102317.04027.ioe-lkml@axxeo.de>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser writes:

> Why not putting the required information into the AUX table
> when executing your ELF programs? I loved this feature in the
> ix86 arch.

We do put an AT_HWCAP entry in the aux table, which is a bitmap of
features supported by the cpu.  But for some applications, such as
programming the performance monitor hardware, you need to know the
specific CPU model and version, and this is a way to provide that
information.

Paul.
