Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267776AbUHSBDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267776AbUHSBDh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 21:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUHSBDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 21:03:37 -0400
Received: from ozlabs.org ([203.10.76.45]:2437 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267776AbUHSBDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 21:03:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16675.64654.945327.265586@cargo.ozlabs.ibm.com>
Date: Thu, 19 Aug 2004 11:04:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: akpm@osdl.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 Fix unbalanced pci_dev_put in EEH code
In-Reply-To: <20040818172501.GF14002@austin.ibm.com>
References: <16674.53330.174867.75311@cargo.ozlabs.ibm.com>
	<20040818172501.GF14002@austin.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas writes:

> Hang on there, you didn't just rename the variable, you also missed a
> teeny chunk of the original patch.  The corrected path is attached below.
> (Well, I rather liked my original var names better, but whatever).

Look closer, I didn't miss the chunk, I solved the race condition that
you mentioned. :)  I did if (!inserted) pci_dev_put(dev) at the end
rather than if (inserted) pci_dev_get(dev).

Paul.
